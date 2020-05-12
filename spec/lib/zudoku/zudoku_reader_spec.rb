# frozen_string_literal: true

require 'spec_helper'
require 'fixtures/sudoku_samples'

describe Zudoku::Reader do
  it 'parses default format' do
    parsed = subject.read_sudoku(Zudoku::Samples::ONE_SOLUTION)
    expect(parsed).to be_an Array
    expect(parsed.length).to be 9
    parsed.each do |row|
      expect(row).to be_an Array
      expect(row.length).to be 9
    end
  end

  it 'reads minimalist input' do
    parsed = subject.read_sudoku(Zudoku::Samples::MINIMALIST_INPUT)
    expect(parsed).to be_an Array
    expect(parsed.length).to be 9
    parsed.each do |row|
      expect(row).to be_an Array
      expect(row.length).to be 9
    end
  end
end
