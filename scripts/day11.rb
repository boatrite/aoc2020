#!/usr/bin/env ruby

require "matrix"

PART = 2
EMPTY = "L"
FLOOR = "."
TAKEN = "#"

input = ARGF.read
map = input.split("\n").map { _1.split("") }
matrix = Matrix[*map]

ap = ->(m) {
  puts m.to_a.map { _1.join "" }.join("\n")
}

base_tick = ->(t, adjacent_seats, m) {
  Matrix.build(m.row_count, m.column_count) { |r, c|
    adj_seats = adjacent_seats[m, r, c]
    if m[r, c] == EMPTY && adj_seats.all? { |(rr, cc)| m[rr, cc] == EMPTY }
      TAKEN
    elsif m[r, c] == TAKEN && adj_seats.count { |rr, cc| m[rr, cc] == TAKEN } >= t
      EMPTY
    else
      m[r, c]
    end
  }
}

tick =
  if PART == 1
    adjacent = ->(m, r, c) {
      max_r = m.row_count - 1
      max_c = m.column_count - 1
      adj_rs = ((r - 1)..(r + 1)).select { |adj_r| adj_r.between?(0, max_r) }
      adj_cs = ((c - 1)..(c + 1)).select { |adj_c| adj_c.between?(0, max_c) }
      adj_coords = adj_rs
        .flat_map { |adj_r| adj_cs.map { |adj_c| [adj_r, adj_c] } }
        .select { |coord| coord != [r, c] }
      adj_coords
    }

    adjacent_seats = ->(m, r, c) {
      adj = adjacent[m, r, c]
      adj.select { |(rr, cc)|
        [EMPTY, TAKEN].include? m[rr, cc]
      }
    }

    base_tick.curry(3)[4, adjacent_seats]
  else
    trace = ->(m, r, c, dr, dc) {
      rr = r
      cc = c
      loop do
        rr += dr
        cc += dc
        break nil unless rr.between?(0, m.row_count - 1)
        break nil unless cc.between?(0, m.column_count - 1)
        break [rr, cc] if m[rr, cc] != FLOOR
      end
    }

    adjacent_seats = ->(m, r, c) {
      deltas = [-1, 0, 1].flat_map { |dr|
        [-1, 0, 1].map { |dc| [dr, dc] }
      } - [[0, 0]]

      deltas.map { |(dr, dc)|
        trace[m, r, c, dr, dc]
      }.compact
    }

    base_tick.curry(3)[5, adjacent_seats]
  end

prev = nil
curr = matrix

loop do
  break if curr == prev
  prev = curr
  curr = tick[prev]
end

count_occupied = ->(m) {
  m.count { _1 == TAKEN }
}

puts count_occupied[curr]
