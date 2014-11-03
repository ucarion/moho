require 'spec_helper'

describe Moho::Parser do
  it 'parses boolean literals' do
    tokens = Moho::Lexer.tokenize('#t')
    expect(Moho::Parser.parse(tokens)).to eq Moho::Lang::Bool.new(true)

    tokens = Moho::Lexer.tokenize('#f')
    expect(Moho::Parser.parse(tokens)).to eq Moho::Lang::Bool.new(false)
  end

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

  it 'raises an error on bad parse' do
    strs = ['(a b c', ') a']

    strs.each do |str|
      expect do
        Moho::Parser.parse(Moho::Lexer.tokenize(str))
      end.to raise_error(Moho::Parser::ParseError)
    end
  end
end
