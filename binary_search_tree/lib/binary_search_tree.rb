# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.
require 'bst_node'
require 'byebug'

class BinarySearchTree
  attr_accessor :root
  
  def initialize
    @root = nil
    @store = []
  end

  def insert(value, tree_node = @root)
    unless @root
      @root = BSTNode.new(value)
      return
    end

    if value <= tree_node.value
      if tree_node.left
        insert(value, tree_node.left)
      else
        tree_node.left = BSTNode.new(value)
        tree_node.left.parent = tree_node
      end
    else
      if tree_node.right
        insert(value, tree_node.right)
      else
        tree_node.right = BSTNode.new(value)
        tree_node.right.parent = tree_node
      end
    end
  end

  def find(value, tree_node = @root)
    return nil unless tree_node

    if tree_node.value == value
      return tree_node
    else
      if value < tree_node.value
        left_node = tree_node.left
        find(value, left_node)
      else
        right_node = tree_node.right
        find(value, right_node)
      end
    end

  end

  def delete(value)
    return nil unless find(value)

    found_node = find(value)
    if found_node.left.nil? && found_node.right.nil?
      return @root = nil if found_node == @root
      
      parent = found_node.parent
      if found_node.value < parent.value
        parent.left = nil
      else
        parent.right = nil
      end
      found_node.parent = nil

    elsif found_node.left && found_node.right
      # puts "We are deleting #{value}"
      left_max = maximum(found_node.left)
      # puts "Replacing with left_max: #{left_max.value}"
      left_max_child = left_max.left ? left_max.left : nil
      @root = left_max if found_node == @root
      
      left_max.left = found_node.left
      left_max.right = found_node.right
      if found_node.parent
        parent = found_node.parent
        # puts "#{value} has a parent: #{parent.value}"

        if found_node.value < parent.value
          # puts "#{value} is < #{parent.value}, so assigning parent.left to left_max: #{left_max.value}"
          parent.left = left_max
          # puts "parent.left.value: #{parent.left.value}"
        else
          parent.right = left_max
        end
        
        found_node.parent = nil
        found_node.left = nil
        found_node.right = nil
        # puts "left_max.parent: #{left_max.parent.value}"
        left_max.parent.right = left_max_child if left_max_child
        # p left_max.parent.value
        
      end

    else
      @root = nil if found_node == @root
      if found_node.left
        child = found_node.left
        found_node.left = nil
      else
        child = found_node.right
        found_node.right = nil
      end

      if found_node.parent
        parent = found_node.parent
        if found_node.value < parent.value
          parent.left = child
        else
          parent.right = child
        end
        found_node.parent = nil
      end
    end
      
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right == nil

    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return -1 if tree_node == nil
    return 0 if !@root.left && !@root.right
    [depth(tree_node.left) + 1, depth(tree_node.right) + 1].max

  end 

  def is_balanced?(tree_node = @root)

  end

  def in_order_traversal(tree_node = @root, arr = [])
    return nil unless tree_node
    in_order_traversal(tree_node.left, arr)
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr)

    arr
  end


  private

end
