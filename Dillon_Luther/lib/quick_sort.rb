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

    return array[0] if array.length == 1

    p array
    pivot_idx = partition(array, start, length)
    p array

    # left = array[start...pivot_idx]
    # right = array[pivot_idx+1..-1]
    # sort2!(left, left[0], left.length) + array[pivot_idx] + sort2!(right, right[0], right.length)

  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    pivot = array[start]
    partition_idx = prc.call(array[start + 1], pivot) < 1 ? start + 2 : start + 1
    pointer_idx = start + 2

    (pointer_idx...(start + length)).each do |idx|
      if prc.call(array[idx], pivot) < 1
        array[partition_idx], array[idx] = array[idx], array[partition_idx]
        partition_idx += 1
      end
    end

    array[start], array[partition_idx - 1] = array[partition_idx - 1], array[start]
    pivot_idx = partition_idx - 1
  end
end

# p QuickSort.sort1([5,12,3,51,1,23,1,23])