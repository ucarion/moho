require 'spec_helper'

describe Moho::Parser do
  it 'parses integer literals' do
    tokens = Moho::Lexer.tokenize('1')
    expect(Moho::Parser.parse(tokens)).to eq Moho::Lang::Int.new(1)
  end
end
