require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    @start_idx = 0
  end

  def dyno
    if @start_idx != 0 && @length > @capacity - @start_idx
      @store[start_idx...@capacity] + @store[0...start_idx]
    else
      @store[@start_idx...@start_idx + length]
    end
  end

  def curr_idx(index)
    (start_idx + index) % @capacity
  end

  def next_idx
    if @length == 0
      @start_idx
    else
      (@start_idx + @length - 1) % @capacity
    end
  end
  
  # O(1)
  def [](index)
    raise "index out of bounds" unless self.check_index(index)
    @store[curr_idx(index)]
  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" unless self.check_index(index)
    @store[curr_idx(index)] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length < 1

    popped = @store[curr_idx(@length - 1)]
    @store[curr_idx(@length - 1)] = nil
    @length -= 1

    popped
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @length += 1
    @store[curr_idx(@length - 1)] = val
    @store
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length < 1

    shifted = @store[@start_idx]
    @store[@start_idx] = nil

    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1

    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
    
  end

  # protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    if index < 0 || index >= @length
      false
    else
      true
    end
  end

  def resize!
    new_store = StaticArray.new(@capacity * 2)

    (0...@length).each do |i|
      new_store[i] = @store[curr_idx(i)]
    end

    @capacity *= 2
    @start_idx = 0
    @store = new_store

    # @store = StaticArray.new(@capacity)
    
    # i = 0
    # while i < @length
    #   @store[i] = dup[i]
    #   i += 1
    # end

    # @store
  end
end
