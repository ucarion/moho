module Moho
  module Lang
    class Expression < Struct.new(:value)
    end

    class List < Expression
      def eval
        operator = value[0].eval

        case operator
        when :quote
          value[1]
        when :if
          pred, conseq, alt = value[1], value[2], value[3]

          if pred.eval != 0
            conseq.eval
          else
            alt.eval
          end
        end
      end
    end

    class Int < Expression
      def eval
        value
      end
    end

    class String < Expression
      def eval
        value
      end
    end

    class Symbol < Expression
      def eval
        value.to_sym
      end
    end
  end
end
