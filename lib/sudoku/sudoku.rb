# frozen_string_literal: true

require 'sudoku/reader'
require 'sudoku/validator'
require 'sudoku/solver'

module Sudoku
  # Main sudoku class. Ideally only represents sudoku data without solution and reading logic
  #
  class Sudoku
    include Validator
    include Solver
    attr_accessor :board, :possibilities, :status, :solutions

    def initialize(input)
      @initial = Reader.read_sudoku(input)
      @board = @initial.map(&:clone)
      @possibilities = generate_possibilities(@board)
      @status = :unsolved # :solved :multiple_solutions :impossible
      @solutions = []
    end

    # returns a string representation of current board
    # @example
    #   board.to_s
    #
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
    def to_s
      @board.map { |row| row.join (' ') }.join("\n")
    end

    private

    def generate_possibilities(board)
      board.map do |row|
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
