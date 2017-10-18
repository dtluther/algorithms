class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    total_obj_id = 0
    self.each_with_index do |el, idx|
      total_obj_id += (el.object_id * (idx + 1))
    end

    total_obj_id.hash
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = 0
    self.each do |k, v|
      sum += (k.hash * v.hash)
    end
    
    sum
  end
end
