require_relative "heap"
class Array
  def heap_sort!
    prc = Proc.new { |x,y| y <=> x }

    boundary_idx = 0
    until (boundary_idx == self.length - 1)
      boundary_idx += 1
      BinaryMinHeap.heapify_up(self, boundary_idx, boundary_idx + 1, &prc)
    end
    
    until boundary_idx == 0
      self[0], self[boundary_idx] = self[boundary_idx], self[0]
      BinaryMinHeap.heapify_down(self, 0, boundary_idx, &prc)
      boundary_idx -= 1
    end
  end
end