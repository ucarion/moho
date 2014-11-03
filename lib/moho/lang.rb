module Moho
  module Lang
    class Expression < Struct.new(:value)
    end

    class Int < Expression
    end

    class String < Expression
    end
  end
end
