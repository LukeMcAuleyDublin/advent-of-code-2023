# frozen_string_literal: true

class Parser # rubocop:disable Style/Documentation
  class << self
    def points(line)
      game_id, winning_numbers, my_numbers = split_line(line)

      cross = winning_numbers & my_numbers
      base_points = 1
      return 0 if cross.count == 0

      (cross.count - 1).times do
        base_points *= 2
      end
      puts("Number of points for game #{game_id} with cross of #{cross} is #{base_points}")
      base_points
    end

    def split_line(line)
      game, rest = line.split(':')
      game_id = game[-1].to_i
      winning_numbers, my_numbers = parse_numbers(rest.split('|'))
      [game_id, winning_numbers, my_numbers]
    end

    def parse_numbers(input)
      input.map { |x| x.split(' ') }.map do |set|
        set.map(&:to_i)
      end
    end
  end
end
