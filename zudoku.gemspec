Gem::Specification.new do |s|
  s.name = %q{Zudoku}
  s.author = 'Steve Redka'
  s.version = "0.1.0"
  s.date = %q{2020-12-05}
  s.summary = %q{Sudoku solver gem}
  s.files = [
    "lib/zudoku.rb"
  ]
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'pry'
end
