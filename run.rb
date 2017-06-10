require 'matrix'
require 'csv'
require '.\lib\ruby_linear_regression.rb'

x_data = []
y_data = []
# Load data from CSV file into two arrays - one for independent variables X and one for the dependent variable Y
# Each row contains square feet for property and living area like this: [ SQ FEET PROPERTY, SQ FEET HOUSE ]
CSV.foreach("data\\staten-island-single-family-home-sales-2015.csv", :headers => true) do |row|
  # use row here...
  x_data.push( [row[0].to_i, row[1].to_i] )
  y_data.push( row[2].to_i )
end

# Create regression model
linear_regression = RubyLinearRegression.new

# Load training data
linear_regression.load_training_data(x_data, y_data)

# Train the model using the normal equation
theta = linear_regression.train_normal_equation

# Output the cost
puts "Trained model with the following cost fit #{linear_regression.compute_cost}"

# Predict the price of a 2000 sq feet property with a 1500 sq feet house
prediction_data = [2000, 1500]
predicted_price = linear_regression.predict(prediction_data)
puts "Perdicted selling price for a 1500 sq feet house on a 2000 sq feet property: #{predicted_price.round}$"
