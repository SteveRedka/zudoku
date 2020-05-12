Gem::Specification.new do |s|
  s.name = %q{sudoku}
  s.author = 'Steve Redka'
  s.version = "0.0.0"
  s.date = %q{2020-12-05}
  s.summary = %q{sudoku solver gem}
  s.files = [
    "lib/sudoku.rb"
  ]
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'pry'
end
