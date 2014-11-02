module Moho
  module Lexer
    class << self
      def tokenize(str)
        tokens = []

        until str.empty?
          token, str = next_token(str)
          tokens << token if token.should_add?
        end

        tokens
      end

      private

      STRING_REGEX = /\"(\\.|[^\"])*\"/

      SYMBOL_OPERATOR_REGEX = /([+\-*\/><=]+)/
      SYMBOL_NAME_REGEX = /([a-z](\w+)?)/
      SYMBOL_REGEX = /(#{SYMBOL_OPERATOR_REGEX}|#{SYMBOL_NAME_REGEX})/

      def next_token(str)
        try_match(str, Whitespace, /\s+/) or
          try_match(str, LParen, /\(/) or
          try_match(str, RParen, /\)/) or
          try_match(str, Int, /\d+/) or
          try_match(str, String, STRING_REGEX) or
          try_match(str, Symbol, SYMBOL_REGEX) or
          raise LexError
      end

      def try_match(str, token_klass, regex)
        if match = get_match(str, regex)
          [token_klass.new(match), str[match.length..-1]]
        end
      end

      def get_match(str, regex)
        match_data = str.match(Regexp.new('\A' + regex.source))
        match_data[0] if match_data
      end
    end

    class LexError < StandardError
    end

    class Token < Struct.new(:text)
      def should_add?
        true
      end
    end

    class LParen < Token
    end

    class RParen < Token
    end

    class Int < Token
    end

    class String < Token
    end

    class Symbol < Token
    end

    class Whitespace < Token
      def should_add?
        false
      end
    end
  end
end
