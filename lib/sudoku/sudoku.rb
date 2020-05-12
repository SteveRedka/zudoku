# Main class
# Contains input, solutions and such

require 'sudoku/reader'

module Sudoku
  class Sudoku
    attr_accessor :board, :possibilities

    def initialize(input)
      @board = Reader.read_sudoku(input)
      generate_possibilities!(@board)
    end

    private

    def generate_possibilities!(board)
      @possibilities = board.map do |row|
        row.map do |cell|
          if cell == '_'
            %w(1 2 3 4 5 6 7 8 9)
          else
            [cell]
          end
        end
      end
    end
  end
end
