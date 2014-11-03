require 'spec_helper'

describe Moho::Parser do
  it 'parses integer literals' do
    tokens = Moho::Lexer.tokenize('1')
    expect(Moho::Parser.parse(tokens)).to eq Moho::Lang::Int.new(1)
  end

  it 'parses string literals' do
    tokens = Moho::Lexer.tokenize('"a"')
    expect(Moho::Parser.parse(tokens)).to eq Moho::Lang::String.new('a')
  end

  it 'parses symbols' do
    tokens = Moho::Lexer.tokenize('a')
    expect(Moho::Parser.parse(tokens)).to eq Moho::Lang::Symbol.new('a')
  end

  it 'parses lists' do
    tokens = Moho::Lexer.tokenize('(max 1 2)')
    ast = Moho::Lang::List.new([
      Moho::Lang::Symbol.new('max'),
      Moho::Lang::Int.new(1),
      Moho::Lang::Int.new(2)
    ])

    expect(Moho::Parser.parse(tokens)).to eq ast
  end

  it 'parses nested lists' do
    tokens = Moho::Lexer.tokenize('(+ 1 (* 2 3))')
    ast = Moho::Lang::List.new([
      Moho::Lang::Symbol.new('+'),
      Moho::Lang::Int.new(1),
      Moho::Lang::List.new([
        Moho::Lang::Symbol.new('*'),
        Moho::Lang::Int.new(2),
        Moho::Lang::Int.new(3)
      ])
    ])

    expect(Moho::Parser.parse(tokens)).to eq ast
  end
end
