module Moho
  module Lang
    class Environment < Struct.new(:bindings, :parent)
      def [](name)
        bindings.fetch(name) { parent[name] }
      end

      def self.global
        Stdlib.env
      end
    end

    class Expression < Struct.new(:value)
    end

    class List < Expression
      def eval(env = Environment.global)
        operator, *arguments = self.value

        case operator.value
        when 'quote'
          value[1]

        when 'if'
          pred, conseq, alt = arguments[0], arguments[1], arguments[2]

          if pred.eval(env)
            conseq
          else
            alt
          end.eval(env)

        when 'lambda'
          params_list, body = value[1], value[2]
          formal_parameters = params_list.value.map(&:value)

          Proc.new do |args|
            bindings = Hash[formal_parameters.zip(args)]
            body.eval(Environment.new(bindings, env))
          end

        else
          evaled_arguments = arguments.map { |exp| exp.eval(env) }
          operator.eval(env).call(evaled_arguments)
        end
      end
    end

    class LiteralExpression < Expression
      def eval(env = Environment.global)
        value
      end
    end

    class Bool < LiteralExpression
    end

    class Int < LiteralExpression
    end

    class String < LiteralExpression
    end

    class Symbol < Expression
      def eval(env = Environment.global)
        env[value]
      end
    end
  end
end
