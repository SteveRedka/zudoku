# frozen_string_literal: true

require 'spec_helper'
require 'fixtures/sudoku_samples'

describe Zudoku::Solution do
  board = [
    ["9", "6", "3", "1", "7", "4", "2", "5", "8"],
    ["1", "7", "8", "3", "2", "5", "6", "4", "9"],
    ["2", "5", "4", "6", "8", "9", "7", "3", "1"],
    ["8", "2", "1", "4", "3", "7", "5", "9", "6"],
    ["4", "9", "6", "8", "5", "2", "3", "1", "7"],
    ["7", "3", "5", "9", "6", "1", "8", "2", "4"],
    ["5", "8", "9", "7", "1", "3", "4", "6", "2"],
    ["3", "1", "7", "2", "4", "6", "9", "8", "5"],
    ["6", "4", "2", "5", "9", "8", "1", "7", "3"]
  ]

  let!(:solution) { Zudoku::Solution.new(board) }

  it 'works like Array of arrays' do
    expect(solution.length).to eq 9
    solution.each do |row|
      expect(row.length).to eq 9
    end
  end

  describe '#to_s' do
    it 'returns its output in multiple lines' do
      str = solution.to_s
      expect(str.split("\n").length).to be >= 9
      expect(str.split("\n").length).to be < 27
    end

    it 'has fancy decorators' do
      expect(solution.to_s).to include('+-------+-------+-------+')
    end
  end
end
