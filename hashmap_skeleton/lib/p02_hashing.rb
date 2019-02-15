class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
     if self.empty?
      0.hash
     else 
      self.inject do |acc, el|
        acc *= el.hash # why does this work if multiplication is associative?
      end
    end 
  end
end

class String
  def hash
    if self == ""
      0.hash
    else  
      alphabet = ("a".."z").to_a
      chars = self.chars.map {|char| alphabet.index(char.downcase) + 1 }
      chars.inject do |acc, el|
        acc *= el.hash
      end
    end 
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
    arr = self.sort_by {|k,v| k }
    # arr.inject do |acc, el|
    #   k, v = el  
    #   acc += 2
    # end
  end
end
