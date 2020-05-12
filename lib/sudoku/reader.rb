# turn input into array of arrays

module Sudoku
  module Reader
    def self.read_sudoku(str)
      rows = str.split("\n")
      normal_rows = rows.select do |row|
        row.strip[0] == '|'
      end
      normal_rows.map do |row|
        row.split(' ').select { |col| col.match(/_|\d/) }
      end
    end
  end
end
