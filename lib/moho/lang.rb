module Moho
  module Lang
    class Environment < Struct.new(:bindings, :parent)
      def [](name)
        bindings.fetch(name) { parent[name] }
      end

      def self.global
        new(global_functions, nil)
      end

      private

      def self.global_functions
        {
          '+' => -> (args) { args[0] + args[1] }
        }
      end
    end

    class Expression < Struct.new(:value)
    end

    class List < Expression
      def eval(env = Environment.global)
        operator = value[0]

        case operator.value
        when 'quote'
          value[1]

        when 'if'
          pred, conseq, alt = value[1], value[2], value[3]

          if pred.eval != 0
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
          arguments = value[1..-1].map { |exp| exp.eval(env) }
          operator.eval(env).call(arguments)
        end
      end
    end

    class Int < Expression
      def eval(env = Environment.global)
        value
      end
    end

    class String < Expression
      def eval(env = Environment.global)
        value
      end
    end

    class Symbol < Expression
      def eval(env = Environment.global)
        env[value]
      end
    end
  end
end
