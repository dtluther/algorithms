# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require 'topological_sort'

def install_order(arr)
    vertices = []

    arr.each do |tuple|
        if vertices.map(&:value).include?(tuple[0]) && vertices.map.(&:value).include?(tuple[1])
            Edge.new
        Edge.new(Vertex.new(tuple[0]), Vertex.new(tuple[1]))
    end

    p arr.map(&:class)
    topological_sort(arr)
end
