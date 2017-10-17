require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    @start_index = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" unless self.check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" unless check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0

    @store[@length - 1] = nil
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
    @store
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0

    shifted = @store[0]

    i = 1
    while i < @length
      @store[i - 1] = @store[i]
      i += 1
    end
    @store[@length - 1] = nil
    @length -= 1

    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity

    i = @length - 1
    while i >= 0
      @store[i+1] = @store[i]
      i -= 1
    end
    @length += 1
    @store[@start_index] = val

    @store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    @start_index + index < @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    dup = @store.dup

    @capacity *= 2
    @store = StaticArray.new(@capacity)
    
    i = 0
    while i < @length
      @store[i] = dup[i]
      i += 1
    end

    @store
  end
end


x = DynamicArray.new