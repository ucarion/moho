module Moho
  class Parser
    def self.parse(tokens)
      token = tokens[0]

      case token
      when Lexer::Int
        Lang::Int.new(token.text.to_i)
      when Lexer::String
        without_quotes = token.text[1...-1]
        Lang::String.new(without_quotes)
      when Lexer::Symbol
        Lang::Symbol.new(token.text)
      end
    end
  end
end
