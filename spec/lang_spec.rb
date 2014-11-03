require 'spec_helper'

describe Moho::Lang do
  it 'evaluates numbers' do
    expect(Moho::Lang::Int.new(3).eval).to eq 3
  end

  it 'evaluates strings' do
    expect(Moho::Lang::String.new('a').eval).to eq 'a'
  end

  it 'evaluates symbols' do
    expect(Moho::Lang::Symbol.new('a').eval).to eq :a
  end
end
