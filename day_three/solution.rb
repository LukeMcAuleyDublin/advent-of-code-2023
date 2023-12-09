require 'pry'

def input
  File.readlines('./input.txt')
end

def has_symbols?(string)
  non_alphanumeric_regex = /[^a-zA-Z0-9.]/
  !string.scan(non_alphanumeric_regex).empty? unless string.nil?
end

def symbol_adjacent?(strings)
  strings.map do |str|
    has_symbols?(str)
  end
end

nums_to_sum = []

input.each_with_index do |line, index|
  nums = line.scan(/-?\d+/)
  
  nums.each do |num|
    num_occ = nums.tally[num]
    if num_occ == 1
      num_index = line.index(num)
      line_1 = input[index - 1][num_index-1..num.size+num_index] unless index == 0
      line_2 = input[index][num_index-1..num.size+num_index]
      line_3 = input[index + 1][num_index-1..num.size+num_index] unless index == (input.size - 1)
      results = symbol_adjacent?([line_1, line_2, line_3])
      if results.any? { |r| r == true }
        nums_to_sum << num.to_i
      end
    else
      0..num_occ.times do |occ|
        num_index = line.index(num, line.index(num) + occ)
        line_1 = input[index - 1][num_index-1..num.size+num_index] unless index == 0
        line_2 = input[index][num_index-1..num.size+num_index]
        line_3 = input[index + 1][num_index-1..num.size+num_index] unless index == (input.size - 1)
        results = symbol_adjacent?([line_1, line_2, line_3])
        if results.any? { |r| r == true }
          nums_to_sum << num.to_i
        end
      end
    end
  end
end

sum = nums_to_sum.map(&:abs).sum

puts("Sum: #{sum}")

