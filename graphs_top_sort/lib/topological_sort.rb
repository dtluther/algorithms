require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Kahn's Algorithm
def topological_sort(vertices)
    return [] if vertices.all? {|vertex| vertex.out_edges.length > 0 }
    
    top = []
    queue = []
    
    vertices.each do |vertex|
        # puts "vertex value: #{vertex.value}"
        if vertex.in_edges.empty?
            # puts "vertex with no in_edges: #{vertex.value}"
            queue << vertex 
            
        end
    end

    # debugger
    until queue.empty?
        u = queue.shift
        u.out_edges.each do |out_edge|
            to_vertex = out_edge.to_vertex
            to_vertex.in_edges.delete(out_edge)
            queue << to_vertex if to_vertex.in_edges.empty?
        end
        
        top << u
    end

   top
end

# debugger displays
# disp vertices.map(&:value)
# disp top.map(&:value)
# disp queue.map(&:value)
# disp u.value
# disp to_vertex.value
# disp u.out_edges.map(&:to_vertex).map(&:value)

# # Tarian's algorithm
# def topological_sort(vertices)
#     output = []

#     vertices.each do |vertex|
#         until vertex.out_edges.empty?
#             vertex.out_edges.each do |out_edge|
# end