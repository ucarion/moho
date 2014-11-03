module Moho
  module Stdlib
    def self.env
      env = {}

      env['+'] = -> (args) { args[0] + args[1] }
      env['-'] = -> (args) { args[0] - args[1] }
      env['*'] = -> (args) { args[0] * args[1] }
      env['/'] = -> (args) { args[0] / args[1] }

      env
    end
  end
end
