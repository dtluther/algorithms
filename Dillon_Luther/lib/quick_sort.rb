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

    return array if array.length <= 1

    # byebug
    if start < length
      pivot_idx = partition(array, start, length)
      left = array[start...pivot_idx]
      right = array[pivot_idx+1...length]
      sort2!(array, start, pivot_idx) if pivot_idx > start
      sort2!(array, pivot_idx + 1, length) if length > pivot_idx
    end

    # print "starting array ", array
    # pivot_idx = partition(array, start, length)
    # print "\narray after pivot ", array

    # left = array[start...pivot_idx]
    # print "\nleft ", left
    # # pivot_left = left.first
    # # boundary_idx = 1
    # # (1...left.length).each do |idx|
    
    # disp array
    # disp current = array[start...length]
    # disp pivot_idx
    # disp array[start...pivot_idx]
    # disp array[pivot_idx]
    # disp array[pivot_idx+1...length]
    # disp start
    # disp length

    # right = array[pivot_idx+1..-1]
    # print " right ", right
    # sort2!(left, left[0], left.length) + array[pivot_idx] + sort2!(right, right[0], right.length)
    # p array
    # partition = partition(array, start, length)
    # p array
    # p partition

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    # pivot = array[start]
    # partition_idx = prc.call(array[start + 1], pivot) < 1 ? start + 2 : start + 1
    # pointer_idx = start + 2

    # (pointer_idx...(start + length)).each do |idx|
    #   if prc.call(array[idx], pivot) < 1
    #     array[partition_idx], array[idx] = array[idx], array[partition_idx]
    #     partition_idx += 1
    #   end
    # end

    # array[start], array[partition_idx - 1] = array[partition_idx - 1], array[start]
    # pivot_idx = partition_idx - 1
    # array
    
    # print 'starting array ', array
    
    return array if array.length <= 1
    
    pivot = array[start]
    partition_idx = start + 1
    
    p array
    p "start: #{start}"
    p "length: #{length}"
    p "partition_idx: #{partition_idx}"
    p "length + start: #{length + start}"
    puts "subarray: #{array[partition_idx...(length + start)]}"
    (partition_idx...(length + start)).each do |idx|
      print "idx: #{idx} array[idx]: #{array[idx]} pivot:  #{pivot} \n"
      if prc.call(array[idx], pivot) < 1
        array[partition_idx], array[idx] = array[idx], array[partition_idx] unless idx == partition_idx
        partition_idx += 1
      end
    end

    array[start], array[partition_idx - 1] = array[partition_idx - 1], array[start]
    pivot_idx = partition_idx - 1
    

    ###Test later, info from http://davidkariuki.com/blog/2014/05/05/a-quicksort-in-place-implementation-in-ruby
    # left_index = start
    # right_index = start + length - 1
    # sub = array[left_index..right_index]
    # pivot = sub[left_index]
    # sub[left_index], sub[right_index] = sub[right_index], sub[left_index]
    # new_pivot_idx = left_index
    # (left_index..right_index).each do |i|
    #   if array[i] <= pivot
    #     array[i], array[new_pivot_idx] = array[new_pivot_idx], array[i]
    #     new_pivot_idx += 1
    #   end
    # end
    # array[new_pivot_idx], array[right_index] = array[right_index], array[new_pivot_idx]
    # new_pivot_idx
  end
end

# p QuickSort.sort1([5,12,3,51,1,23,1,23])
# p QuickSort.partition([3, 1, 5, 2, 4], 0, 5)
p QuickSort.partition([1, 3, 4, 2], 0, 4)
p QuickSort.partition([3, 4, 2], 0, 3)
p QuickSort.partition([2], 0, 1)
