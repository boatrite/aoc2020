#!/usr/bin/env ruby

required_fields = %w[byr iyr eyr hgt hcl ecl pid]
optional_fields = %w[cid]

input = ARGF.read
batches = input.split("\n\n")
passports = batches.map { |batch| batch.split("\n").join(" ") }

answer = passports.count { |passport|
  required_fields.all? { |field|
    break false unless passport.include?(field)

    match = passport.match(/#{field}:(.+?)(\s|$)/)
    if match.nil?
      require "pry"; binding.pry
      puts "hi"
    end
    value = match[1]

    case field
    when "byr"
      value = value.to_i
      break false unless value >= 1920 && value <= 2002
    when "iyr"
      value = value.to_i
      break false unless value >= 2010 && value <= 2020
    when "eyr"
      value = value.to_i
      break false unless value >= 2020 && value <= 2030
    when "hgt"
      hgt_match = value.match(/(\d+)(cm|in)/)
      break false if hgt_match.nil?

      hgt_value = hgt_match[1].to_i
      hgt_unit = hgt_match[2]

      case hgt_unit
      when "in"
        break false unless hgt_value >= 59 && hgt_value <= 76
      when "cm"
        break false unless hgt_value >= 150 && hgt_value <= 193
      end
    when "hcl"
      break false unless value.match?(/#[0-9a-f]{6}/)
    when "ecl"
      break false unless %w[amb blu brn gry grn hzl oth].include? value
    when "pid"
      break false unless value.match?(/^\d{9}$/)
    else
      true
    end
    true
  }
}

puts answer
