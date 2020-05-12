# turn input into array of arrays

module Sudoku
  module Reader
    def self.read_sudoku(str)
      str = str.strip
      rows = str.split("\n")
      rows.select! do |row|
        row[0] == '|'
      end
      rows.map do |row|
        row.split(' ').select { |col| col.match(/_|\d/) }
      end
    end
  end
end
