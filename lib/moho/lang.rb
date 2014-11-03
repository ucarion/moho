module Moho
  module Lang
    class Expression < Struct.new(:value)
    end

    class Int < Expression
    end

    class String < Expression
    end

    class Symbol < Expression
    end

    class List < Expression
    end
  end
end
