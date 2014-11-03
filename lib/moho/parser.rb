module Moho
  class Parser
    class << self
      def parse(tokens)
        raise ParseError if tokens.empty?
        raise ParseError if tokens[0].is_a?(Lexer::RParen)
        token = tokens.shift

        case token
        when Lexer::BoolTrue
          handle_literal(token, Lang::Bool) { true }
        when Lexer::BoolFalse
          handle_literal(token, Lang::Bool) { false }
        when Lexer::Int
          handle_literal(token, Lang::Int, &:to_i)
        when Lexer::String
          # we need to remove the intial and final quotes on the string.
          handle_literal(token, Lang::String) { |text| text[1...-1] }
        when Lexer::Symbol
          handle_literal(token, Lang::Symbol, &:to_s)
        when Lexer::LParen
          list_elems = []

          list_elems << parse(tokens) until tokens[0].is_a?(Lexer::RParen)
          tokens.shift # pop off the final ')'

          Lang::List.new(list_elems)
        end
      end

      private

      def handle_literal(token, klass, &block)
        klass.new(block.call(token.text))
      end
    end

    class ParseError < StandardError
    end
  end
end
