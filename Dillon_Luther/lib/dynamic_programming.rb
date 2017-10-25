class DynamicProgramming

  def initialize
    @blair_cache = {
      1 => 1,
      2 => 2
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

    frog_cache[n]
  end

  def frog_cache_builder(n)
    frog_cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }

    return frog_cache if n <= 3

    (4..n).each do |i|
      new_combos = []
      # frog_cache[i - 1].each do |combo|
      #   new_combos << combo.concat(1)
      #   combo.map do |num|

      frog_cache[i] = 2 ** (i - 1)
    end

    frog_cache
  end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
