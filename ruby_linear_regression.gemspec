Gem::Specification.new do |s|
  s.name        = "ruby_linear_regression"
  s.version     = "0.1.7"
  s.date        = "2024-09-04"
  s.summary     = "Linear regression implemented in Ruby."
  s.description = %q{An implementation of a linear regression machine learning algorithm implemented in Ruby.
  The library supports simple problems with one independent variable used to predict a dependent variable as well as multivariate problems with multiple independent variables to predict a dependent variable.
  You can train your algorithms using the normal equation or gradient descent.
  The library is implemented in pure ruby using Ruby's Matrix implementation.}
  s.authors     = ["Soren Blond Daugaard"]
  s.email       = "sbd@ineptum.dk"
  s.files       = ["lib/ruby_linear_regression.rb"]
  s.homepage    =
    'https://github.com/daugaard/linear-regression'
  s.license       = 'MIT'
  s.add_dependency 'matrix'
  s.add_development_dependency 'csv'
  s.add_development_dependency 'minitest', '~> 5.10', '>= 5.10.2'
end
