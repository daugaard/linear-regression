Gem::Specification.new do |s|
  s.name        = "ruby_linear_regression"
  s.version     = "0.1.1"
  s.date        = "2017-06-13"
  s.summary     = "Linear regression implemented in Ruby."
  s.description = %q{An implementation of a linear regression machine learning algorithm implemented in Ruby.

  Features:
  - Supports simple problems with one independent variable to predict a dependent variable and multivariate problems with multiple independent variables to predict a dependent variable.
  - Supports training using the normal equation
  - Supports training using gradient descent
  - The library is implemented in pure ruby using Ruby's Matrix implementation.

  An example of how to use the library can be found in the blog post: [Implementing linear regressing using Ruby](http://www.practicalai.io/implementing-linear-regression-using-ruby/). }
  s.authors     = ["Soren Blond Daugaard"]
  s.email       = "sbd@ineptum.dk"
  s.files       = ["lib/ruby_linear_regression.rb"]
  s.homepage    =
    'https://github.com/daugaard/linear-regression'
  s.license       = 'MIT'
  s.add_development_dependency 'minitest', '~> 5.10', '>= 5.10.2'
end
