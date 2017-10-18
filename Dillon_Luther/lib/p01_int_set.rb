class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {false}
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num <= @max && num >= 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = num % num_buckets
    @store[bucket] << num
  end

  def remove(num)
    bucket = num % num_buckets
    @store[bucket].delete(bucket)

  end

  def include?(num)
    bucket = num % num_buckets
    @store[bucket].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    bucket_num = num % num_buckets
    @store[bucket_num] << num
    @count += 1
  end

  def remove(num)
    bucket_num = num % num_buckets
    @store[bucket_num].delete(num)
    @count -= 1
  end

  def include?(num)
    bucket_num = num % num_buckets
    @store[bucket_num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    doubled_buckets = num_buckets * 2
    new_store = Array.new(doubled_buckets) { Array.new }

    @store.each do |bucket|
      bucket.each do |num|
        bucket_num = num % doubled_buckets
        new_store[bucket_num] << num
      end
    end

    @store = new_store
  end
end
