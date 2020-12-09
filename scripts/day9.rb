#!/usr/bin/env ruby

input = ARGF.read
numbers = input.split("\n").map(&:to_i)

PART = 2

if PART == 1
  preamble_length = 25

  puts numbers[preamble_length..-1].find.with_index { |x, i|
    ii = i + preamble_length
    window = numbers[(ii - preamble_length)..(ii - 1)]
    window.permutation(2).none? { |a, b|
      a + b == x
    }
  }

else
  target = 1504371145
  # target = 127

  (2..numbers.length).find { |window_length|
    numbers.each_cons(window_length).find { |window|
      answer = window.sum == target
      puts window.max + window.min if answer
      answer
    }
  }
end
