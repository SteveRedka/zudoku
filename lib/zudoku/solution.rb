# frozen_string_literal: false

module Zudoku
  # Class with functions related to parsing sudokus
  class Solution < Array
    def to_s
      arr = flatten
      str = ''
      (0...81).each do |i|
        str << "|\n+-------+-------+-------+\n" if i % 27 == 0
        str << "| " if i % 3 == 0
        str << "\n| " if i % 9 == 0 && i != 0 &&i % 27 != 0
        str << "#{arr[i]} "
      end
      str << "|\n+-------+-------+-------+\n"
      str [2..-1]
    end

    def inspect
      to_s
    end
  end
end
