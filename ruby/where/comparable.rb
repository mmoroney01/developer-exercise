module Comparable
  def where(h)
    self.select do |item|
      h.all? do |key, value|
        if value.kind_of?(Regexp)
          item[key].match(value)
        else
          item[key] == value
        end
      end
    end
  end
end

class Array
  include Comparable
end