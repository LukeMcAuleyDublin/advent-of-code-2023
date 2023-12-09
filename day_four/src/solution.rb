# frozen_string_literal: true

require_relative 'parser'

class Solution # rubocop:disable Style/Documentation
  class << self
    def input
      File.readlines('../input.txt')
    end

    def perform
      result =
        input.map do |line|
          Parser.points(line.split("\n")[0])
        end
      result.sum
    end
  end
end

puts(Solution.perform)
