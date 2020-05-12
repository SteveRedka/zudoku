# frozen_string_literal: true

module Sudoku
  # validations
  #
  module Validator
    # Checks if sudoku `@board` follows sudoku rules
    #
    def valid?
      rows_valid? && cols_valid? && squares_valid?
    end

    # Checks row for duplicates
    #
    def rows_valid?
      @board.each do |row|
        assigned_values = row.reject { |c| c == '_' }
        unless assigned_values == assigned_values.uniq
          return false
        end
      end
      true
    end

    # Checks column for duplicates
    #
    def cols_valid?
      @board.transpose.each do |col|
        assigned_values = col.reject { |c| c == '_' }
        unless assigned_values == assigned_values.uniq
          return false
        end
      end
    end

    # Checks square for duplicates.
    #
    # First two cycles iterate squares, second two iterate cells in squares
    def squares_valid?
      (0...3).each do |sq_i|
        (0...3).each do |sq_j|
          square = []
          (0...3).each do |i|
            (0...3).each do |j|
              square << @board[sq_i * 3 + i][sq_j * 3 + j]
            end
          end
          assigned_values = square.reject { |c| c == '_' }
          unless assigned_values == assigned_values.uniq
            return false
          end
        end
      end
      true
    end
  end
end
