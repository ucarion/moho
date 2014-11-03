module Moho
  class Parser
    class << self
      def parse(tokens)
        token = tokens[0]

        case token
        when Lexer::Int
          handle_literal(token, Lang::Int, &:to_i)
        when Lexer::String
          # we need to remove the intial and final quotes on the string.
          handle_literal(token, Lang::String) { |text| text[1...-1] }
        when Lexer::Symbol
          handle_literal(token, Lang::Symbol, &:to_s)
        end
      end

      private

      def handle_literal(token, klass, &block)
        klass.new(block.call(token.text))
      end
    end
  end
end
