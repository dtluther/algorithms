class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new
    @count = 0
    @prc ||= Proc.new { |x, y| x <=> y }
  end

  def count
  end

  def extract
  end

  def peek
  end

  def push(val)
    @store.push(val)
    @count += 1
  end

  public
  def self.child_indices(len, parent_index)
    child_1_index = 2*parent_index + 1
    child_2_index = 2*parent_index + 2
    
    children_indices = []
    children_indices << child_1_index if child_1_index < len
    children_indices << child_2_index if child_2_index < len

    children_indices
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    parent_index = (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= @prc

    children_indices = self.class.heapify_down(len, parent_idx)

    unless children_indices.empty?
      greatest_child_idx = children_indices.max || children_indices[0]
    end

    case prc(array[parent_idx], array[greatest_child_idx])
    when -1
      array[parent_idx], array[greatest_child_idx] = array[greatest_child_idx], array[parent_idx]
    end

    

  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
