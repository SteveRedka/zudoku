# frozen_string_literal: true

module Sudoku
  # Class with functions related to parsing sudokus
  module Reader
    # turn input into array of arrays
    #
    # @param [String] str
    #
    # `str` may be [String] or [Array]
    #
    # Strings should contain numbers and underscores separated by whitespaces
    #
    # @example This is valid input
    #   +-------+-------+-------+
    #   | _ 6 _ | 1 _ 4 | _ 5 _ |
    #   | _ _ 8 | 3 _ 5 | 6 _ _ |
    #   | 2 _ _ | _ _ _ | _ _ 1 |
    #   +-------+-------+-------+
    #   | 8 _ _ | 4 _ 7 | _ _ 6 |
    #   | _ _ 6 | _ _ _ | 3 _ _ |
    #   | 7 _ _ | 9 _ 1 | _ _ 4 |
    #   +-------+-------+-------+
    #   | 5 _ _ | _ _ _ | _ _ 2 |
    #   | _ _ 7 | 2 _ 6 | 9 _ _ |
    #   | _ 4 _ | 5 _ 8 | _ 7 _ |
    #   +-------+-------+-------+
    #
    # @example This is valid input as well
    #   _ 6 _ 1 _ 4 _ 5 _
    #   _ _ 8 3 _ 5 6 _ _
    #   2 _ _ _ _ _ _ _ 1
    #   8 _ _ 4 _ 7 _ _ 6
    #   _ _ 6 _ _ _ 3 _ _
    #   7 _ _ 9 _ 1 _ _ 4
    #   5 _ _ _ _ _ _ _ 2
    #   _ _ 7 2 _ 6 9 _ _
    #   _ 4 _ 5 _ 8 _ 7 _
    #
    def self.read_sudoku(str)
      return str if str.is_a?(Array)

      rows = str.split("\n")

      splitted_rows = rows.map do |row|
        row.split(' ').select { |chr| chr.match(/_|\d/) }
      end

      splitted_rows.select do |row|
        row.length == 9
      end
    end
  end
end
