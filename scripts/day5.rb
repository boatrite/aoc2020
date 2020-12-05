#!/usr/bin/env ruby

input = ARGF.read

do_test = ->(test, init_min, init_max) {
  ans1, ans2 = test.chars.reduce([init_min, init_max]) { |(min, max), char|
    case char
    when "F", "L"
      max -= ((max - min) / 2.0).ceil
    when "B", "R"
      min += ((max - min) / 2.0).ceil
    end
    [min, max]
  }

  unless ans1 == ans2
    require "pry"; binding.pry
  end

  ans1
}

get_rcid = ->(boarding_pass) {
  r = do_test[boarding_pass[0..6], 0, 127]
  c = do_test[boarding_pass[7..10], 0, 7]
  id = r * 8 + c
  [r, c, id]
}

array = input.split("\n").map { |boarding_pass|
  _, _, id = get_rcid[boarding_pass]
  id
}.sort

puts array.select.with_index { |id, index|
  id - 1 != array[index - 1]
}
