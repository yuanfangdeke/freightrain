
module Freightrain

  class BooleanConverter

    def from(val)
      return val != nil
    end

    def to(val)
      return val == true #dummy
    end

  end
end
