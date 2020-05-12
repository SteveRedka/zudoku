# Sudoku.rb
Gem for solving sudoku.

It uses advanced programming techniques such as `if` statements and recursion.

# Installation

```ruby
# Gemfile
gem `zudoku`, git: 'git://github.com/SteveRedka/zudoku.git'
```

# Usage
```ruby
puzzle = '''
  +-------+-------+-------+
  | _ _ _ | 1 _ 4 | _ 5 _ |
  | _ _ _ | 3 _ 5 | 6 _ _ |
  | _ _ _ | _ _ _ | _ _ 1 |
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
sudoku = Zudoku::Sudoku.new(puzzle)
sudoku.solve!
# :multiple_solutions
sudoku.status
# :solved or :multiple solutions if puzzle is valid
sudoku.solutions[0].to_s
# +-------+-------+-------+
# | 9 6 3 | 1 7 4 | 2 5 8 |
# | 1 7 8 | 3 2 5 | 6 4 9 |
# | 2 5 4 | 6 8 9 | 7 3 1 |
# +-------+-------+-------+
# | 8 2 1 | 4 3 7 | 5 9 6 |
# | 4 9 6 | 8 5 2 | 3 1 7 |
# | 7 3 5 | 9 6 1 | 8 2 4 |
# +-------+-------+-------+
# | 5 8 9 | 7 1 3 | 4 6 2 |
# | 3 1 7 | 2 4 6 | 9 8 5 |
# | 6 4 2 | 5 9 8 | 1 7 3 |
# +-------+-------+-------+
```

Solutions are stored in `@solutions` variable because sometimes multiple are possible. In that case, `@board` will
store incomplete puzzle just before splitting.

# Input
Parser ignores most text decorations and only cares about numbers, line endings, underscores and spaces.

This is valid input too:
```
_ 6 _ 1 _ 4 _ 5 _
_ _ 8 3 _ 5 6 _ _
2 _ _ _ _ _ _ _ 1
8 _ _ 4 _ 7 _ _ 6
_ _ 6 _ _ _ 3 _ _
7 _ _ 9 _ 1 _ _ 4
5 _ _ _ _ _ _ _ 2
_ _ 7 2 _ 6 9 _ _
_ 4 _ 5 _ 8 _ 7 _
```
And of course, Array of Arrays can be used as well.
