class DynamicProgramming

  def initialize
    @blair_cache = {
      1 => 1,
      2 => 2
    }

    @frog_cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }

    @super_cache = {

    }
  end

  def blair_nums(n)
    if !@blair_cache[n].nil?
      return @blair_cache[n]
    else
      blair_odd = ((n - 1) * 2) - 1
      ans = blair_odd + blair_nums(n - 1) + blair_nums(n - 2)

      @blair_cache[n] = ans

      @blair_cache[n]
    end
  end

  def frog_hops_bottom_up(n)
    frog_cache = frog_cache_builder(n)

    # p frog_cache[5]
    frog_cache[n]
  end

  def frog_cache_builder(n)
    frog_cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }

    return frog_cache if n <= 3

    # p frog_cache
    (4..n).each do |i|
      new_combos = []
      frog_cache[i - 1].each do |combo|
        # p "#{i} => #{combo}"
        new_combos << (combo.dup << 1)
      end
      # p "after i - 1: #{frog_cache}"
      # p "#{new_combos}"
      frog_cache[i - 2].each do |combo|
        new_combos << (combo.dup << 2)
      end
      # p "after i - 2: #{frog_cache}"
      # p "#{new_combos}"
      frog_cache[i - 3].each do |combo|
        new_combos << (combo.dup << 3)
      end
      # p "#{new_combos}"

      # p frog_cache
      frog_cache[i] = new_combos
      # p frog_cache
    end

    frog_cache
  end


  def frog_hops_top_down(n)
    # # Without cache
    # return [[1]] if n == 1
    # return [[1, 1], [2]] if n == 2
    # return [[1, 1, 1], [1, 2], [2, 1], [3]] if n == 3

    # modified_last = frog_hops_top_down(n - 1).map {|arr| arr.dup << 1}
    # modified_penultimate = frog_hops_top_down(n - 2).map {|arr| arr.dup << 2}
    # modified_third_to_last = frog_hops_top_down(n - 3 ).map {|arr| arr.dup << 3 }

    # modified_last + modified_penultimate + modified_third_to_last

    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    if !@frog_cache[n].nil?
      return @frog_cache[n]
    else
      modified_last = frog_hops_top_down(n - 1).map {|arr| arr.dup << 1}
      modified_penultimate = frog_hops_top_down(n - 2).map {|arr| arr.dup << 2}
      modified_third_to_last = frog_hops_top_down(n - 3 ).map {|arr| arr.dup << 3 }
      
      @frog_cache[n] = modified_last + modified_penultimate + modified_third_to_last
    end
  end

  def super_frog_hops(n, k)
    super_cache = super_frog_cache_builder(n, k)
    super_cache[n]
  end

  def super_frog_cache_builder(n, k)
    super_frog_cache = {
      1 => [[1]]
    }

    (2..n).each do |step|
      super_frog_cache[step] = []
      (1..[k,step - 1].min).each do |hop|
        super_frog_cache[step] += super_frog_cache[step - hop].map{|hops| hops + [hop]}
      end
      super_frog_cache[step] += [[step]] if step <= k
    end

    super_frog_cache
  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end