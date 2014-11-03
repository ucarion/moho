require 'spec_helper'

describe Moho::Lang do
  it 'evaluates numbers' do
    expect(Moho::Lang::Int.new(3).eval).to eq 3
  end

  it 'evaluates strings' do
    expect(Moho::Lang::String.new('a').eval).to eq 'a'
  end

  it 'works with quote' do
    str = '(quote (1))'
    expression = Moho::Parser.parse(Moho::Lexer.tokenize(str))

    list = Moho::Lang::List.new([Moho::Lang::Int.new(1)])
    expect(expression.eval).to eq list
  end

  it 'works with if' do
    str = '(if 1 "yes" "no")'
    expression = Moho::Parser.parse(Moho::Lexer.tokenize(str))

    expect(expression.eval).to eq 'yes'

    str = '(if 0 "yes" "no")'
    expression = Moho::Parser.parse(Moho::Lexer.tokenize(str))

    expect(expression.eval).to eq 'no'
  end

  it 'works with lambda' do
    str = '((lambda (x) (+ 1 x)) 3)'
    expression = Moho::Parser.parse(Moho::Lexer.tokenize(str))

    expect(expression.eval).to eq 4
  end
end
