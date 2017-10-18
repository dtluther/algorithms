require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
#   @store = HashMap.new(string.length)

#   string.chars.each do |ch|
#   end

  count = Hash.new(0)

  string.each_char do |ch|
    count[ch] += 1
  end

  ones_count = count.count { |k, v| v == 1}

  ones_count <= 1 ? true : false
end
