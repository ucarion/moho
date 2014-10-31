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

      def next_token(str)
        try_match(str, LParen, /\(/) ||
          try_match(str, RParen, /\)/) ||
          try_match(str, Int, /\d+/) ||
          try_match(str, String, /\"(\\.|[^\"])*\"/)
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
  end
end
