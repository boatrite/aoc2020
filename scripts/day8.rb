#!/usr/bin/env ruby

input = ARGF.read
program = input.split("\n")

class Computer
  def initialize(program)
    @acc = 0
    @ip = 0
    @visited_instructions = []
    @program = program
  end

  def call
    loop do
      break false if @visited_instructions.include?(@ip)
      break @acc if @ip == @program.size
      @visited_instructions << @ip
      ins = @program[@ip]
      case ins
      in /nop/
        @ip += 1
      in /acc (.+)/
        param = $~[1].to_i
        @acc += param
        @ip += 1
        in /jmp (.+)/
        param = $~[1].to_i
        @ip += param
      end
    end
  end
end

# answer = Computer.new(program).call
# puts answer

# To solve part 2, brute force check each permutation of the program to find
# one that terminates.
program.find.with_index { |ins, index|
  case ins
  when /acc/
    false
  when /nop/, /jmp/
    mutated_program = program.clone
    mutated_program[index] =
      if ins.match?("nop")
        mutated_program[index].sub("nop", "jmp")
      else
        mutated_program[index].sub("jmp", "nop")
      end

    answer = Computer.new(mutated_program).call
    print "\r#{answer}"
    !!answer
  end
}
