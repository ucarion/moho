require 'spec_helper'

describe Moho::Lexer do
  it "tokenizes parentheses" do
    str = "((()))"
    tokens = [Moho::Lexer::LParen.new] * 3 + [Moho::Lexer::RParen.new] * 3

    expect(Moho::Lexer.tokenize(str)).to eq tokens
  end
  # it "tokenizes simple strings" do
  #   phrase = "(define pi 3.14)"
  #   tokens = ["(", "define", "pi", "3.14", ")"]

  #   expect(Moho::Lexer.tokenize(phrase)).to eq tokens
  # end

  # it "tokenizes strings with strings in them" do
  #   phrase = "(define str \"hello world\")"
  #   tokens = ["(", "define", "str", "\"hello world\"", ")"]

  #   expect(Moho::Lexer.tokenize(phrase)).to eq tokens
  # end
end
