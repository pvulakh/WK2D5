require "byebug"
class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false) 
  end

  def insert(num)
    # debugger
    if (num <= self.store.length - 1) && num >= 0 
      self.store[num] = true 
      true
    else  
      # debugger
      raise "Out of bounds"
    end 
  end

  def remove(num)
    if (num <= self.store.length - 1) && num >= 0 
      self.store[num] = false
      true
    else  
      raise "Out of bounds"
    end 
  end

  def include?(num)
    if self.store[num] == false
      return false
    elsif self.store[num] == true
      return true
    else
      raise "Out of bounds"
    end
  end

  protected
  attr_accessor :store

  private


  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_accessor :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    #debugger
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    self.store[num % num_buckets] 
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self.include?(num)
      self[num] << num
      self.count += 1
      resize! if self.count >= num_buckets
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      self.count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end
  protected
  attr_writer :store, :count
  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    self.store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    all_nums = self.store.flatten
    new_store = Array.new(num_buckets * 2) { Array.new }
    self.store = new_store
    self.count = 0

    all_nums.each do |num|
      self.insert(num)
    end
  end
end
