# frozen_string_literal: true

module Sudoku
  # Solver functions
  #
  # Files in this class are extracted for convenience, although they are closely tied to main [Sudoku::Sudoku] class.
  module Solver
    # Attempts to solve the puzzle.
    #
    # Long story short, it runs a few cycles trying to reduse all possibilities for each cell.
    # If that doesn't work, it tries to solve puzzle recursively for all available possibilities
    #
    # @return puzzle status. Either `:multiple_solutions`, `:solved` or `:impossible`
    #
    def solve!
      @progress = true unless @status == :solved
      while @progress do
        @progress = false
        prev_iteration_len = @possibilities.flatten.length
        reduce_possibilities!
        @progress = true unless prev_iteration_len == @possibilities.flatten.length
      end
      if @status == :unsolved
        if @board.flatten.include?('_')
          handle_forks!
          @status = @solutions.length > 0 ? :multiple_solutions : :impossible
        else
          @status = :solved
          @solutions << @board
        end
      end
      @status
    end

    # Makes a reduction step, trying to reduce possible values for each cell.
    #
    # If there are no possible values, it sets sudoku status to impossible.
    # If there is only one, it sets a value to board.
    #
    # All possible values for each cell are stored in `@possibilities` variable.
    #
    def reduce_possibilities!
      @status = :impossible unless valid?
      @possibilities.each_with_index do |row, i|
        break if @status == :impossible
        row.each_with_index do |cell, j|
          break if @status == :impossible
          next if cell.length == 1

          neighbors = find_row_neighbors(i, j) + find_col_neighbors(i, j) + find_square_neighbors(i, j)
          @possibilities[i][j] -= neighbors
          if @possibilities[i][j].length == 0
            @status = :impossible
          elsif @possibilities[i][j].length == 1
            @board[i][j] = @possibilities[i][j][0]
          end
        end
      end
    end

    # Finds all known numbers in same row, excluding the one in current cell
    #
    # @example
    #   find_row_neighbors(3, 4)
    #   +-------+-------+-------+
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   +-------+-------+-------+
    #   | ! ! ! | ! _ ! | ! ! ! |
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   +-------+-------+-------+
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   +-------+-------+-------+
    def find_row_neighbors(x, y)
      @board[x].reject { |cell| cell == '_' || cell == @board[x][y] }
    end

    # Finds all known numbers in same column, excluding the one in current cell
    #
    # @example
    #   find_col_neighbors(3, 4)
    #   +-------+-------+-------+
    #   | _ _ _ | _ ! _ | _ _ _ |
    #   | _ _ _ | _ ! _ | _ _ _ |
    #   | _ _ _ | _ ! _ | _ _ _ |
    #   +-------+-------+-------+
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   | _ _ _ | _ ! _ | _ _ _ |
    #   | _ _ _ | _ ! _ | _ _ _ |
    #   +-------+-------+-------+
    #   | _ _ _ | _ ! _ | _ _ _ |
    #   | _ _ _ | _ ! _ | _ _ _ |
    #   | _ _ _ | _ ! _ | _ _ _ |
    #   +-------+-------+-------+
    def find_col_neighbors(x, y)
      @board.transpose[y].reject { |cell| cell == '_' || cell == @board[x][y] }
    end

    # Finds all known numbers in same square, excluding the one in current cell
    #
    # @example
    #   find_square_neighbors(3, 4)
    #   +-------+-------+-------+
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   +-------+-------+-------+
    #   | _ _ _ | ! _ ! | _ _ _ |
    #   | _ _ _ | ! ! ! | _ _ _ |
    #   | _ _ _ | ! ! ! | _ _ _ |
    #   +-------+-------+-------+
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   | _ _ _ | _ _ _ | _ _ _ |
    #   +-------+-------+-------+
    def find_square_neighbors(x, y)
      result = []
      @board.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          next if [i, j] == [x, y]
          result << cell if [i / 3, j / 3] == [x / 3, y / 3]
        end
      end
      result.reject { |c| c == '_' }
    end

    # If there are multiple possiblities and no way to reduce them, this function attempts to recursively solve
    # all puzzle variants starting from first tile having multiple possibilities.
    #
    # All solutions are placed into `@solutions` variable of main [Sudoku::Sudoku] instance.
    #
    def handle_forks!
      fork_found = false
      @possibilities.each_with_index do |row, i|
        break if fork_found
        row.each_with_index do |cell, j|
          break if fork_found
          if @possibilities[i][j].length > 1
            fork_found = true
            solutions = @possibilities[i][j].map do |possibility|
              new_board = @board.map(&:clone)
              new_board[i][j] = possibility
              sudoku = Sudoku.new(new_board)
              sudoku.solve!
              @solutions += sudoku.solutions unless sudoku.status == :impossible
            end
          end
        end
      end
    end
  end
end
