require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if !self.include?(key)
      bucket(key).append(key, val)
      self.count += 1
    else  
      bucket(key).update(key, val)
    end

    resize! if self.count >= num_buckets
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    self.count -= 1
  end

  def each
     store.each do |bucket|
      bucket.each do |node|
        yield [node.key, node.val]
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_num_bucket = self.store.length * 2
    new_store = Array.new(new_num_bucket) { LinkedList.new }
    self.count = 0 
    all_pairs = []

    self.each do |k, v|
      all_pairs << [k, v]
    end 

    all_pairs.each do |k, v|
      new_store[k.hash % new_num_bucket].append(k, v)
      self.count += 1
    end 

    self.store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    self.store[key.hash % num_buckets]
  end
end
