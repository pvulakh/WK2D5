class HashSet
  attr_reader :count
  attr_accessor :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self.include?(num.hash)
      self[num] << num.hash
      self.count += 1
      resize! if self.count >= num_buckets
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num.hash) 
      self.count -= 1
    end
  end

  def include?(num)
    self[num].include?(num.hash)
  end

  protected
  attr_writer :count

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    self.store[num.hash % num_buckets]
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
