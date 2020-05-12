require 'spec_helper'

describe Sudoku::Sudoku do
  let!(:input) { '''
    +-------+-------+-------+
    | _ 6 _ | 1 _ 4 | _ 5 _ |
    | _ _ 8 | 3 _ 5 | 6 _ _ |
    | 2 _ _ | _ _ _ | _ _ 1 |
    +-------+-------+-------+
    | 8 _ _ | 4 _ 7 | _ _ 6 |
    | _ _ 6 | _ _ _ | 3 _ _ |
    | 7 _ _ | 9 _ 1 | _ _ 4 |
    +-------+-------+-------+
    | 5 _ _ | _ _ _ | _ _ 2 |
    | _ _ 7 | 2 _ 6 | 9 _ _ |
    | _ 4 _ | 5 _ 8 | _ 7 _ |
    +-------+-------+-------+
    '''
  }
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
end
