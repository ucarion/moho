module Moho
  module Lang
    class Expression < Struct.new(:value)
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

    class List < Expression
    end
  end
end
