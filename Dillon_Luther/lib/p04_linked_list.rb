class Node
  attr_accessor :key, :val, :next, :prev

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
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next, @tail.prev = @tail, @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    empty? ? nil : @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_node = @head.next
    until current_node == @tail
      return current_node.val if current_node.key == key
      current_node = current_node.next
    end

    nil
  end

  def include?(key)
    self.each do |node|
      if node.key == key
        return true
      end
    end

    false
  end

  def append(key, val)
    link = Node.new(key, val)

    link.prev = @tail.prev
    @tail.prev.next = link

    link.next = @tail
    @tail.prev = link
  end

  def update(key, val)
    current_node = @head.next
    until current_node == @tail || current_node.key == key 
      current_node = current_node.next
    end

    if current_node.key == key
      current_node.val = val
    end
  end

  def remove(key)
    current_node = @head.next
    until current_node == @tail || current_node.key == key
      current_node = current_node.next
    end

    if current_node.key == key
      current_node.prev.next = current_node.next
      current_node.next.prev = current_node.prev
    end
    
    nil
  end

  def each
    current_node = @head.next
    until current_node == @tail
      yield current_node
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end
