# Ruby Linear Regression
An implementation of a linear regression machine learning algorithm implemented in Ruby. This algorithm uses Ruby's Matrix implementation and the normal equation to train the data to the best fit.

The algorithm works with one or many independent variables to predict a dependent variable.

## Installation
```
  gem install ruby_linear_regression
```

## Example of usage using Normal Equation

```Ruby
require 'matrix'
require 'csv'
require 'ruby_linear_regression'

x_data = []
y_data = []
# Load data from CSV file into two arrays - one for independent variables X (x_data) and one for the dependent variable y (y_data)
CSV.foreach("staten-island-single-family-home-sales-2015.csv", :headers => true) do |row|
  # Each row contains square feet for property and living area like this: [ SQ FEET PROPERTY, SQ FEET HOUSE ]  
  x_data.push( [row[0].to_i, row[1].to_i] )
  y_data.push( row[2].to_i )
end

# Create regression model
linear_regression = RubyLinearRegression.new

# Load training data
linear_regression.load_training_data(x_data, y_data)

# Train the model using the normal equation
linear_regression.train_normal_equation

# Output the cost
puts "Trained model with the following cost fit #{linear_regression.compute_cost}"

# Predict the price of a 2000 sq feet property with a 1500 sq feet house
prediction_data = [2000, 1500]
predicted_price = linear_regression.predict(prediction_data)
puts "Perdicted selling price for a 1500 sq feet house on a 2000 sq feet property: #{predicted_price.round}$"
```

More details about this example implementation can be found in this [blog post](http://www.practicalai.io/implementing-linear-regression-using-ruby/).

## Example of usage using Gradient Descent

```Ruby
require 'matrix'
require 'csv'
require 'ruby_linear_regression'

x_data = []
y_data = []
# Load data from CSV file into two arrays - one for independent variables X (x_data) and one for the dependent variable y (y_data)
CSV.foreach("staten-island-single-family-home-sales-2015.csv", :headers => true) do |row|
  # Each row contains square feet for property and living area like this: [ SQ FEET PROPERTY, SQ FEET HOUSE ]  
  x_data.push( [row[0].to_i, row[1].to_i] )
  y_data.push( row[2].to_i )
end

# Create regression model
linear_regression = RubyLinearRegression.new

# Load training data
linear_regression.load_training_data(x_data, y_data)

# Train the model using gradient descent
linear_regression_gradient_descent.train_gradient_descent(0.0005, 1000, true)

# Output the cost
puts "Trained model with the following cost fit #{linear_regression.compute_cost}"

# Predict the price of a 2000 sq feet property with a 1500 sq feet house
prediction_data = [2000, 1500]
predicted_price = linear_regression.predict(prediction_data)
puts "Perdicted selling price for a 1500 sq feet house on a 2000 sq feet property: #{predicted_price.round}$"
```
