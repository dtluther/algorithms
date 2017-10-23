## Almost sorted

# Timestamped data may not always make it into the database in the
# perfect order. Server loads, network routes, etc. Your job is to
# take in a very long sequence of numbers in real-time and efficiently
# print it out in the correct order. Each number is, at most, `k` away
# from its final sorted position. Target time complexity is `O(nlogk)`
# and target space is `O(k)`.

require_relative 'heap'

def almost_sorted(arr, k = arr.length)
    heap = BinaryMinHeap.new

    arr.each_with_index do |num, idx|
        if idx < k
            heap.push(num)
        else
            p heap.extract
            heap.push(num)
        end
    end

    # p 'current heap', heap

    loop do
        begin
            p heap.extract
        rescue
            return "done"
        end
    end

end
