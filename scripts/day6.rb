#!/usr/bin/env ruby

input = ARGF.read
groups = input.split("\n\n")
answer = groups.map { |group|
  lines = group.split("\n").map { |line| line.chars }
  lines.reduce(("a".."z").to_a) { |shared_chars, line_chars|
    shared_chars & line_chars
  }.count
}.sum

puts answer
