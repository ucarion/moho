require 'spec_helper'

describe Moho::Lexer do
  it "tokenizes parentheses" do
    str = "((()))"
    tokens = [Moho::Lexer::LParen.new('(')] * 3 +
      [Moho::Lexer::RParen.new(')')] * 3

    expect(Moho::Lexer.tokenize(str)).to eq tokens
  end

  it "tokenizes numbers" do
    str = "123"
    tokens = [Moho::Lexer::Int.new("123")]

    expect(Moho::Lexer.tokenize(str)).to eq tokens
  end

  it "tokenizes strings" do
    str = "\"hello world\""
    tokens = [Moho::Lexer::String.new("\"hello world\"")]

    expect(Moho::Lexer.tokenize(str)).to eq tokens
  end

  it "tokenizes symbols" do
    symbols = ["hello", "+", "atan2", ">>="]

    symbols.each do |sym|
      expect(Moho::Lexer.tokenize(sym)).to eq [Moho::Lexer::Symbol.new(sym)]
    end
  end

  it "puts it all together" do
    str = "(a 1 \"s\")"
    tokens = [
      Moho::Lexer::LParen.new('('),
      Moho::Lexer::Symbol.new('a'),
      Moho::Lexer::Int.new('1'),
      Moho::Lexer::String.new('"s"'),
      Moho::Lexer::RParen.new(')')
    ]

    expect(Moho::Lexer.tokenize(str)).to eq tokens
  end
end
