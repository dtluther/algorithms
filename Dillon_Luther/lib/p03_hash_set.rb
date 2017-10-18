require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    bucket_num = key.hash % num_buckets
    @store[bucket_num] << key
    @count += 1
  end

  def include?(key)
    bucket_num = key.hash % num_buckets
    @store[bucket_num].include?(key)
  end

  def remove(key)
    bucket_num = key.hash % num_buckets
    @store[bucket_num].delete(key)
    @count -= 1
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
    new_store = Array.new(doubled_buckets) {Array.new}

    @store.each do |bucket|
      bucket.each do |key|
        bucket_num = key.hash % doubled_buckets
        new_store[bucket_num] << key
      end
    end

    @store = new_store
  end
end
