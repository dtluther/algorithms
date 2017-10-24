# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require 'topological_sort'

def install_order(arr)
    max = arr.flatten.max
    vertices = {}

    (1..max).each do |id|
        vertices[id] = Vertex.new(id)
    end

    arr.each do |tuple|
        package = tuple[0]
        dependency = tuple[1]
        Edge.new(vertices[dependency], vertices[package])
    end

    topological_sort(vertices.values).map(&:value)

end
