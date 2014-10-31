module Moho
  class Lexer
    class << self
      def tokenize(str)
        tokens = []

        until str.empty?
          token, str = next_token(str)
          tokens << token
        end

        tokens
      end

      private

      STRING_REGEX = "\\\"(\\\\.|[^\\\"])*\\\""

      SYMBOL_OPERATOR_REGEX = "([+\\-*/><=]+)"
      SYMBOL_NAME_REGEX = "([a-z]\\w+)"
      SYMBOL_REGEX = "(#{SYMBOL_OPERATOR_REGEX}|#{SYMBOL_NAME_REGEX})"

      def next_token(str)
        try_match(str, LParen, "\\(") ||
          try_match(str, RParen, "\\)") ||
          try_match(str, Int, "\\d+") ||
          try_match(str, String, STRING_REGEX) ||
          try_match(str, Symbol, SYMBOL_REGEX)
      end

      def try_match(str, token_klass, regex)
        if match = get_match(str, regex)
          [token_klass.new(match), str[match.length..-1]]
        end
      end

      def get_match(str, regex)
        match_data = str.match(Regexp.new('\A' + regex))
        match_data[0] if match_data
      end
    end

    class Token < Struct.new(:text)
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
  end
end
