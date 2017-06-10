# Ruby Linear Regression
An implementation of a linear regression machine learning algorithm implemented in Ruby. This algorithm uses Ruby's Matrix implementation and the normal equation to train the data to the best fit. The algorithm works with multiple independent variables to predict a dependent variable.

## Example of usage

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

# Load regression model
linear_regression = RubyLinearRegression.new(x_data, y_data)

# Train the model using the normal equation
theta = linear_regression.train_normal_equation

# Output the cost / error - this  is a meassure of how good the fit it
puts linear_regression.compute_cost

# Predict the price of a 2000 sq feet property with a 1500 sq feet house
puts linear_regression.predict [4000, 2500]
```
