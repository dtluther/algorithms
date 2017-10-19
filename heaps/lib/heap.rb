# require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new
    @prc ||= Proc.new { |x, y| x <=> y }
  end

  def count
    @store.length
  end

  def extract
    tail_idx = count - 1
    @store[0], @store[tail_idx] = @store[tail_idx], @store[0]

    extracted = @store.pop
    @store = self.class.heapify_down(@store, 0, count, &@prc)
    extracted
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    @store = self.class.heapify_up(@store, count - 1, count, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    child_1_index = 2*parent_index + 1
    child_2_index = 2*parent_index + 2
    
    children_indices= [child_1_index, child_2_index].select { |index| index < len }
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    parent_index = (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    children_indices = child_indices(len, parent_idx)

    until children_indices.empty?
      if  children_indices.length == 2
        greatest_child_idx = prc.call(array[children_indices[0]], array[children_indices[1]]) == 1 ?
        children_indices[1] :
        children_indices[0]
      else
        greatest_child_idx = children_indices[0]
      end

      # p 'jdaljdejkdleldkj', prc.call(array[parent_idx], array[greatest_child_idx])
      if prc.call(array[parent_idx], array[greatest_child_idx]) == 1
        array[parent_idx], array[greatest_child_idx] = array[greatest_child_idx], array[parent_idx]
        parent_idx = greatest_child_idx
        children_indices = child_indices(len, parent_idx)
      else
        return array
      end
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    parent_idx = child_idx


    until parent_idx == 0
      child_idx = parent_idx
      parent_idx = self.parent_index(parent_idx)
      if prc.call(array[parent_idx], array[child_idx]) == 1
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      else
        return array
      end
    end

    array
  end
end
