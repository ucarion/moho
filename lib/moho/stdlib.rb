module Moho
  class Stdlib
    def self.env
      @@env
    end

    @@env = {}

    env['+'] = -> (args) { args[0] + args[1] }
    env['-'] = -> (args) { args[0] - args[1] }
    env['*'] = -> (args) { args[0] * args[1] }
    env['/'] = -> (args) { args[0] / args[1] }
  end
end
