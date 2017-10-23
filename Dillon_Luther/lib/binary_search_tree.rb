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
      left_max = maximum(found_node.left)
      @root = left_max if found_node == @root
      
      left_max.left = found_node.left
      left_max.right = found_node.right
      if found_node.parent
        parent = found_node.parent

        if found_node.value < parent.value
          parent.left = nil
          parent.left = left_max
        else
          parent.right = nil
          parent.right = left_max
        end
        
        found_node.parent = nil
        
      end

    else
      @root = nil if found_node == @root
      child = found_node.left ? found_node.left : found_node.right
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
  end 

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  def subtree(node)

  end

end
