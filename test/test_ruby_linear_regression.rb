require 'minitest/autorun'
require 'csv'
#require 'ruby_linear_regression'
require './lib/ruby_linear_regression.rb'

class RubyLinearRegressionTest < Minitest::Test
  def test_will_normalize_data_when_loaded
    linear_regression = RubyLinearRegression.new

    linear_regression.load_training_data [[0],[10],[20]], [1,2,3]

    assert_equal linear_regression.x, Matrix[[1, -0.5], [1,0.0], [1, 0.5]]
  end

  def test_can_make_predicition_with_1_independent_variable
    linear_regression = RubyLinearRegression.new

    linear_regression.load_training_data [[0],[10],[20]], [1,2,3]

    linear_regression.train_normal_equation

    assert_equal linear_regression.predict([5]), 1.5
  end

  def test_can_perfectly_fit_a_straight_line
    linear_regression = RubyLinearRegression.new

    linear_regression.load_training_data [[0],[10],[20]], [1,2,3]

    linear_regression.train_normal_equation

    assert_equal 2, linear_regression.theta.row_size, "Theta must have 2 rows"

    assert_equal linear_regression.compute_cost, 0
  end

  def test_can_make_predicition_with_2_independent_variable
    linear_regression = RubyLinearRegression.new

    linear_regression.load_training_data [[0,200],[1,300],[2,2000]], [1,2,3]

    linear_regression.train_normal_equation

    assert_equal 3, linear_regression.theta.row_size, "Theta must have 3 rows"

    assert_equal 1.5, linear_regression.predict([0.5,250]).round(1)
  end

  def test_can_make_predicition_with_4_independent_variable
    linear_regression = RubyLinearRegression.new

    linear_regression.load_training_data [[0,200,3,43],[1,300,89,3],[2,2000,23,7]], [1,2,3]

    linear_regression.train_normal_equation

    assert_equal 5, linear_regression.theta.row_size, "Theta must have 5 rows"

    assert_equal false, linear_regression.predict([2,233,4,23]).nan?, "Prediction cannot be NaN"

  end

  def test_can_predict_with_know_data
    x_data = []
    y_data = []
    # Load data from CSV file into two arrays - one for independent variables X and one for the dependent variable Y
    CSV.foreach("data/ex1data1.txt", :headers => false) do |row|
      x_data.push( [row[0].to_f] )
      y_data.push( row[1].to_f )
    end

    linear_regression = RubyLinearRegression.new

    linear_regression.load_training_data x_data, y_data

    # Initial cost with a 0,0 theta
    assert_equal 32.07, linear_regression.compute_cost.round(2)

    linear_regression.train_normal_equation

    assert_equal linear_regression.predict( [3.5] ).round(4), 0.2798
    assert_equal linear_regression.predict( [7] ).round(4), 4.4555

  end


end
