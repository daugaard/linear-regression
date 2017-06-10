Gem::Specification.new do |s|
  s.name        = "ruby_linear_regression"
  s.version     = "0.0.1"
  s.date        = "2017-10-06"
  s.summary     = "Linear regression implemented in Ruby."
  s.description = %q{An implementation of a linear regression machine learning algorithm implemented in Ruby.
                This algorithm uses Ruby's Matrix implementation and the normal equation to train the data to the best fit.
                The algorithm works with multiple independent variables to predict a dependent variable. }
  s.authors     = ["Soren Blond Daugaard"]
  s.email       = "sbd@ineptum.dk"
  s.files       = ["lib/ruby_linear_regression.rb"]
  s.homepage    =
    'https://github.com/daugaard/linear-regression'
  s.license       = 'MIT'
end
