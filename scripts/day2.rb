#!/usr/bin/env ruby

PART = 2

input = ARGF.read

x = input.split("\n")

x = x.filter { |line|
  regex = /^(\d+)-(\d+) (\w): (\w+)$/
  match = line.match(regex)

  if PART == 1
    min_count = match[1].to_i
    max_count = match[2].to_i
    rule_char = match[3]
    password = match[4]

    char_count = password.count(rule_char)
    char_count >= min_count && char_count <= max_count
  elsif PART == 2
    first_pos = match[1].to_i
    second_pos = match[2].to_i
    rule_char = match[3]
    password = match[4]

    (password[first_pos - 1] == rule_char && password[second_pos - 1] != rule_char) ||
      (password[first_pos - 1] != rule_char && password[second_pos - 1] == rule_char)
  end
}

puts x.count
