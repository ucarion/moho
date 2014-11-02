module Moho
  class Parser
    def self.parse(tokens)
      token = tokens[0]

      case token
      when Lexer::Int
        Lang::Int.new(token.text.to_i)
      end
    end
  end
end
