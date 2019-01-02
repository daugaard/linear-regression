require 'matrix'

# RubyLinearRegression
class RubyLinearRegression

  attr_reader :x,:y,:theta,:mu,:sigma, :lambda, :normalize

  def initialize
    @mu = 0
    @sigma = 1
  end

  # Loads and normalizes the training data, must be called prior to training.
  # Arguments:
  #   x_data: (Two dimensiolnal array with the independent variables of your training data)
  #   y_data: (Array with the dependent variables of your training data)
  def load_training_data x_data, y_data, normalize = true

        @normalize = normalize

        # normalize the x_data
        x_data = normalize_data( x_data ) if @normalize

        # add 1 column to our data
        x_data = x_data.map { |r| [1].concat(r) }

        # build our x Matrix & y Vector
        @x = Matrix.rows( x_data )
        @y = Matrix.rows( y_data.collect { |e| [e] } )

        @theta = Matrix.zero(@x.column_size, 1)
  end

  # Compute the mean squared cost / error function
  def compute_cost test_x = nil, test_y = nil

    if not test_x.nil?
      test_x.each_index do |row|
        test_x[row].each_index do |i|
          test_x[row][i] = (test_x[row][i] - @mu[i]) / @sigma[i].to_f
        end
      end if @normalize
      test_x = test_x.map { |r| [1].concat(r) }
    end

    # per default use training data to compute cost if no data is given
    cost_x = test_x.nil? ? @x : Matrix.rows( test_x )
    cost_y = test_y.nil? ? @y : Matrix.rows( test_y.collect { |e| [e] } )

    # First use matrix multiplication and vector subtracton to find errors
    errors = (cost_x * @theta) - cost_y

    # Then square all errors
    errors = errors.map { |e| (e.to_f**2)  }

    # Find the mean of the square errors
    mean_square_error = 0.5 * (errors.inject{ |sum, e| sum + e }.to_f / errors.row_size)

    return mean_square_error
  end

  # Calculate the optimal theta using the normal equation
  def train_normal_equation l = 0

    @lambda = l
    lambda_matrix = Matrix.build(@theta.row_size,@theta.row_size) do |c,r|
        (( c == 0 && r == 0) || c != r) ? 0 : 1;
      end

    # Calculate the optimal theta using the normal equation
    # theta = ( X' * X )^1 * X' * y
    @theta = (@x.transpose * @x + @lambda * lambda_matrix ).inverse * @x.transpose * @y

    return @theta
  end

  # Calculate optimal theta using gradient descent
  # Arguments:
  #   alpha: Learning rate
  #   iterations: Number of iterations to run gradient descent
  #   verbose: If true will output cost after each iteration, can be used to find optimal learning rate (alpha) and iteration
  def train_gradient_descent( alpha = 0.01, iterations = 500, verbose = false )

    0.upto( iterations ) do |i|
      @temp_theta = Array.new(@theta.row_size)
      0.upto(@theta.row_size-1) do |row|
        @temp_theta[row] = @theta[row,0] - alpha * compute_gradient(row)
      end

      @theta = Matrix.columns([@temp_theta])

      puts "Cost after #{i} iterations = #{compute_cost}" if verbose
    end

  end

  # Makes a prediction based on your trained model.
  # train_normal_equation must be called prior to making a prediction.
  #
  # Arguments:
  #   data: (Array of independent variables to base your prediction on)
  def predict data

    # normalize
    data.each_index do |i|
      data[i] = (data[i] - @mu[i]) / @sigma[i].to_f
    end if @normalize

    # add 1 column to prediction data
    data = [1].concat( data )

    # perform prediction
    prediction = (Matrix[data] * @theta)[0,0].to_f

    return prediction

  end

  private
    def normalize_data(x_data, mu = nil, sigma = nil)

      row_size = x_data.size
      column_count = x_data[0].is_a?( Array) ? x_data[0].size : 1

      x_norm = Array.new(row_size)
      @mu = Array.new(column_count)
      @sigma = Array.new(column_count)

      0.upto(column_count - 1) do |column|
        column_data = x_data.map{ |e| e[column] }
        @mu[column] = column_data.inject{ |sum, e| sum + e } / row_size
        @sigma[column] = (column_data.max - column_data.min)
      end

      0.upto(row_size-1) do |row|
        row_data = x_data[row]
        x_norm[row] = Array.new(column_count)
        row_data.each_index do |i|
          x_norm[row][i] = (row_data[i] - @mu[i]) / @sigma[i].to_f
        end
      end

      return x_norm

    end

    # Compute the mean squared cost / error function
    def compute_gradient( parameter )

      # First use matrix multiplication and vector subtracton to find errors
      gradients = ((@x * @theta) - @y).transpose * @x.column(parameter)

      # Mean the grandient
      mean = gradients.inject{ |sum, e| sum + e } / gradients.size

      return mean
    end
end
