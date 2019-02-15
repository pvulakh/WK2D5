class Node
  
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    self.head.next = self.tail
    self.tail.prev = self.head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    self.head.next
  end

  def last
    self.tail.prev
  end

  def empty?
    self.head.next == self.tail
  end

  def get(key)
    current_node = self.head.next
    until self.tail == current_node
      return current_node.val if current_node.key == key 
      current_node = current_node.next 
    end
  end

  def include?(key)
    current_node = self.head.next
    until self.tail == current_node
      return true if current_node.key == key 
      current_node = current_node.next 
    end
    false
  end

  def append(key, val)
    new_last_val = Node.new(key, val) #create E
    last_val = self.tail.prev #get access to L from T's data
    new_last_val.prev = last_val #link E to point to L
    last_val.next = new_last_val #link L to point to E
    new_last_val.next = self.tail #link E to point to T
    self.tail.prev = new_last_val   #link T to point back to E
  end

  def update(key, val)
    current_node = self.head.next
    until self.tail == current_node
      return current_node.val = val if current_node.key == key 
      current_node = current_node.next 
    end
  end

  def remove(key)
    current_node = self.head.next
    until self.tail == current_node
      if current_node.key == key 
        prev_node = current_node.prev
        next_node = current_node.next
        prev_node.next = next_node
        next_node.prev = prev_node
      end 
      current_node = current_node.next 
    end
  end

  def each
    current = self.head.next
    until self.tail == current
      yield current
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
