module Moho
  class Stdlib
    class << self
      def env
        @env ||= make_stdlib
      end

      private

      def make_stdlib
        env = {}

        env['+'] = plus
        env['-'] = minus
        env['*'] = times
        env['/'] = div
        env['='] = eq

        env
      end

      def plus
        -> (args) { args[0] + args[1] }
      end

      def minus
        -> (args) { args[0] - args[1] }
      end

      def times
        -> (args) { args[0] * args[1] }
      end

      def div
        -> (args) { args[0] / args[1] }
      end

      def eq
        -> (args) { args[0] == args[1] }
      end
    end
  end
end
