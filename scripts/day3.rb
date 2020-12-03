#!/usr/bin/env ruby

input = ARGF.read
lines = input.split("\n")

slopes = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
]

answer = slopes.reduce(1) { |acc, slope|
  dx = slope[0]
  dy = slope[1]

  x = 0
  y = 0
  trees = 0

  asdf = loop {
    x += dx
    y += dy

    break trees if y >= lines.length

    line = lines[y]
    tree_found = line[x % line.length] == "#"

    trees += 1 if tree_found
  }

  puts asdf

  acc * asdf
}

puts answer
