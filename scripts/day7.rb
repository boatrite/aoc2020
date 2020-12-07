#!/usr/bin/env ruby

require "rgl/adjacency"
require "rgl/traversal"
require "rgl/dot"
require "rgl/path"

PART = 2
input = ARGF.read
rules = input.split("\n")
target = "shiny gold"

if PART == 1
  vertices = rules.flat_map { |rule|
    scan = rule.scan(/(\w+ \w+) bag/).flatten
    outer = scan[0]
    inners = scan[1..-1]
    inners.flat_map { |inner|
      [outer, inner]
    }
  }

  dg = RGL::DirectedAdjacencyGraph[*vertices]
  rev = dg.reverse
  bfs = rev.bfs_iterator
  bfs.start_vertex = target
  puts bfs.count - 1
else
  vertices = []
  edge_weights = {}

  rules.each do |rule|
    outer = rule.match(/^(\w+ \w+) bag/)[1]
    inners_with_count = rule.scan(/(\d+ \w+ \w+) bag/).flatten
    inners_with_count.each do |inner_with_count|
      _, count, inner = inner_with_count.match(/(\d+) (\w+ \w+)/).to_a
      edge = [outer, inner]
      edge_weights[edge] = count.to_i
      vertices.push(*edge)
    end
  end

  dg = RGL::DirectedAdjacencyGraph[*vertices]

  do_it = ->(graph, node) {
    adjs = graph.adjacent_vertices(node)
    1 + adjs.sum { |adj|
      edge_weights[[node, adj]] * do_it[graph, adj]
    }
  }

  # answer = do_it[dg, "faded blue"]
  # puts answer

  # answer = do_it[dg, "dotted black"]
  # puts answer

  # answer = do_it[dg, "vibrant plum"]
  # puts answer

  # answer = do_it[dg, "dark olive"]
  # puts answer

  answer = do_it[dg, target]
  puts answer - 1
end
