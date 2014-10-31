module Moho
  class Lexer
    class << self
      def lex(str)
        Lang::Int.new(str.to_i)
      end

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
        if match = get_match(str, /\(/)
          [LParen.new, str[match.length .. -1]]
        elsif match = get_match(str, /\)/)
          [RParen.new, str[match.length .. -1]]
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
      def initialize
        super
        self.text = '('
      end
    end

    class RParen < Token
      def initialize
        super
        self.text = ')'
      end
    end
  end
end
