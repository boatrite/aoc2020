#!/usr/bin/env ruby

input = ARGF.read

instructions = input.split("\n")

answer = instructions.reduce([0, 0, 0]) { |(x, y, angle), instruction|
  _, move, num = instruction.match(/([NSEWLRF])(\d+)/).to_a
  num = num.to_i
  case move
  when "N"
    x += num
  when "S"
    x -= num
  when "E"
    y += num
  when "W"
    y -= num
  when "L"
    angle = (angle + num) % 360
  when "R"
    angle = (angle - num) % 360
  when "F"
    case angle
    when 0
      y += num # E
    when 90
      x += num # N
    when 180
      y -= num # W
    when 270
      x -= num # S
    end
  end
  [x, y, angle]
}

dx, dy, angle = answer
puts dx.abs + dy.abs
