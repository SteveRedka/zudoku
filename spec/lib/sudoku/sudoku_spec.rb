# frozen_string_literal: true

require 'spec_helper'
require 'fixtures/sudoku_samples'

describe Sudoku::Sudoku do
  let!(:input) { Sudoku::Samples::ONE_SOLUTION }
  let!(:sudoku) { Sudoku::Sudoku.new(input) }

  it 'initializes board' do
    expect(sudoku.board).to be_an Array
    sudoku.board.each do |row|
      expect(row).to be_an Array
      expect(row.length).to be 9
    end
  end

  it 'initializes possibilities' do
    expect(sudoku.possibilities).to be_an Array
    expect(sudoku.possibilities[0][0]).to eq %w(1 2 3 4 5 6 7 8 9)
  end

  describe '#find_row_neighbors' do
    it 'finds row neighbors' do
      expect(sudoku.find_row_neighbors(1, 2)).to include('3', '5', '6')
      expect(sudoku.find_row_neighbors(1, 2)).not_to include('8')
      expect(sudoku.find_row_neighbors(1, 2)).not_to include('_')
    end
  end

  describe '#find_col_neighbors' do
    it 'finds column neighbors' do
      expect(sudoku.find_col_neighbors(1, 2)).to include('6', '7')
      expect(sudoku.find_col_neighbors(1, 2)).not_to include('8')
      expect(sudoku.find_col_neighbors(1, 2)).not_to include('_')
    end
  end

  describe '#find_square_neighbors' do
    it 'finds square neighbors' do
      expect(sudoku.find_square_neighbors(3, 3)).to include('7', '9', '1')
      expect(sudoku.find_square_neighbors(3, 3)).not_to include('4')
      expect(sudoku.find_square_neighbors(3, 3)).not_to include('_')
    end
  end

  describe '#reduce_possibilities!' do
    it 'limits legal numbers for that cell' do
      sudoku.reduce_possibilities!
      expect(sudoku.possibilities[0][0]).to include('3', '9')
      expect(sudoku.possibilities[0][0]).not_to include('1', '2', '4', '5', '6', '8')
    end

    it 'assigns result to board if reduced successfully' do
      sudoku.reduce_possibilities!
      expect(sudoku.board[8][8]).to eq '3'
    end
  end

  describe '#valid?' do
    it 'returns false with impossible board' do
      impossible_sudoku = Sudoku::Sudoku.new(input)
      impossible_sudoku.board = [['9'] * 9] * 9
      impossible_sudoku.board[0][0] = '_'
      expect(impossible_sudoku.valid?).to be false
    end
  end

  describe '#solve!' do
    context 'impossible' do
      it 'returns :impossible' do
        impossible_sudoku = Sudoku::Sudoku.new(input)
        impossible_sudoku.board = [['9'] * 9] * 9
        impossible_sudoku.board[0][0] = '_'
        expect(impossible_sudoku.solve!).to eq :impossible
      end
    end

    it 'solves a puzzle with one solution' do
      sudoku.solve!
      expect(sudoku.solutions.length).not_to be 0
    end

    it 'solves a puzzle with multiple solutions' do
      sudoku = Sudoku::Sudoku.new(Sudoku::Samples::MULTIPLE_SOLUTIONS)
      sudoku.solve!
      expect(sudoku.status).to eq :multiple_solutions
      expect(sudoku.solutions.count).to eq 3
    end
  end
end
