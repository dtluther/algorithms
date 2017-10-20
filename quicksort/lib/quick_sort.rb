require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return [] if array.length < 1

    pivot = array.first

    left, right = [], []
    array[1..-1].each do |num|
      if num <= pivot
        left << num
      else
        right << num
      end
    end

    sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y } 

    return if length <= 1

    pivot_idx = partition(array, start, length, &prc)
    sort2!(array, start, pivot_idx - start, &prc)
    sort2!(array, pivot_idx + 1, length - (pivot_idx+1), &prc )

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
        
    pivot = array[start]
    partition_idx = start + 1
    
    (partition_idx...(length + start)).each do |idx|
      if prc.call(array[idx], pivot) < 1
        array[partition_idx], array[idx] = array[idx], array[partition_idx] unless idx == partition_idx
        partition_idx += 1
      end
    end

    array[start], array[partition_idx - 1] = array[partition_idx - 1], array[start]
    pivot_idx = partition_idx - 1
    p pivot_idx, array
    pivot_idx
    

  end
end

# p QuickSort.sort1([5,12,3,51,1,23,1,23])
# p QuickSort.partition([3, 1, 5, 2, 4], 0, 5)
QuickSort.partition([1, 3, 4, 2], 0, 4)
QuickSort.partition([3, 4, 2], 0, 3)
QuickSort.partition([2], 0, 1)
