#!/usr/bin/env ruby

PART = 2
input = ARGF.read
joltages = input.split("\n").map(&:to_i).sort
device_joltage = joltages.max + 3

if PART == 1
  chain = [0] + joltages + [device_joltage]
  diffs = chain.each_cons(2).map { |a, b| b - a }
  one_diffs, three_diffs = diffs.group_by(&:itself).values.map(&:count)
  puts one_diffs * three_diffs
else
  # x = joltages.reduce(1) { |acc, j|
  # break acc if j == joltages.last
  # count = joltages.count { |other_j|
  # other_j - j <= 3 &&
  # other_j - j >= 1
  # }
  # puts count
  # acc * count
  # }
  # puts x

  # x = joltages.map { |j|
  # compatible = joltages.select { |other_j|
  # other_j - j <= 3 &&
  # other_j - j >= 1
  # }
  # [j, compatible]
  # }
  # y = x.chunk_while { |(j, compatible), (other_j, other_compatible)|
  # (compatible & other_compatible).any?
  # }.to_a
  # require "pry"; binding.pry
  # groups = y.map(&:flatten).map(&:uniq)
  # require "pry"; binding.pry
  # z = groups.map { |group|
  # group.count { |el| el != group.first && el != group.last }
  # }.select(&:nonzero?)
  # require "pry"; binding.pry
  # answer = z.map { |q| 2**q }.reduce(1) { |acc, v| acc * v }
  # require "pry"; binding.pry
  # puts answer

  # FIXME This doesn't work because the number are NOT totally independent.
  # e.g.
  # If I have the hypothetical sequence 1, 4, 5, 7, 8, 9, 10
  #
  # Taken individually,
  # 7 can be gone. (5 -> 8)
  # 8 can be gone. (7 -> 9)
  # 9 can be gone. (8 -> 10)
  # BUT
  # All of 7, 8 and 9 CANNOT be gone. (because 5 -> 10 is not possible)
  #
  # So it makes sense my real answer is too high. However, it does not make
  # sense why my ex2 answer is TOO LOW. WHAT THE FUCK???
  joltages = [0] + joltages + [device_joltage]
  foobar = ->(list) {
    list.select.with_index { |j, i|
      if i == 0 || i == list.size - 1
        false
      else
        pr = list[i - 1]
        ne = list[i + 1]
        ne - pr <= 3 && ne - pr >= 1
      end
    }
  }
  puts foobar[joltages]
  # What if I take these numbers I just generated, and created new list of
  # joltages **without** _that_ number, and ran the algorithm again?
  # Recursively?
end

# starting_joltage = 0
# chain = []

# find_next_adapter = ->(joltage, remaining_joltages) {
# compatible_adapters = remaining_joltages.select { |other_joltage|
# other_joltage - joltage <= 3 &&
# other_joltage - joltage >= 1
# }
# case compatible_adapters.length
# when 0
# nil
# when 1
# compatible_adapters.first
# else
# require "pry"; binding.pry
# compatible_adapters.find { |next_joltage|
# find_next_adapter[next_joltage, remaining_joltages - [next_joltage]]
# }
# end
# }
# puts find_next_adapter[0, joltages]
# puts find_next_adapter[1, joltages - [1]]
# puts find_next_adapter[4, joltages - [1, 4]]
# puts find_next_adapter[5, joltages - [1, 4, 5]]

# current_joltage = starting_joltage
# remaining_joltages = joltages.clone
# while chain.length != joltages.length
# next_adapter = find_next_adapter[current_joltage, remaining_joltages]
# chain << next_adapter
# remaining_joltages.delete next_adapter
# current_joltage = next_adapter
# end

# require "pry"; binding.pry
# puts "hi"

# ------------------

# foobar = ->(chain, remaining_joltages) {
# return chain if remaining_joltages.empty?

# current_joltage = chain.last
# print "\r#{remaining_joltages.length}      "

# candidate_joltages = remaining_joltages.select { |other_joltage|
# other_joltage - current_joltage <= 3 &&
# other_joltage - current_joltage >= 1
# }

# return chain if candidate_joltages.empty?

# candidate_chains = candidate_joltages.map { |j|
# chain + [j]
# }

# candidate_chains.flat_map do |candidate_chain|
# candidate_remaining_voltages = remaining_joltages - [candidate_chain.last]
# foobar[candidate_chain, candidate_remaining_voltages]
# end
# }

# chain = foobar[[0], joltages] + [device_joltage]
# puts ""

# diffs = chain.each_cons(2).map { |a, b| b - a }
# one_diffs, three_diffs = diffs.group_by(&:itself).values.map(&:count)
# puts chain.join ", "
# puts one_diffs
# puts three_diffs
# puts one_diffs * three_diffs
