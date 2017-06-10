class RubyLinearRegression

  def initialize

  end

  def load_training_data x_data, y_data

        # normalize the x_data
        x_data = normalize_data( x_data )

        # add 1 column to our data
        x_data = x_data.map { |r| [1].concat(r) }

        # build our x Matrix & y Vector
        @x = Matrix.rows( x_data )
        @y = Matrix.rows( y_data.collect { |e| [e] } )

        @theta = Matrix[[0],[0]]
  end

  def compute_cost
    # Compute the mean squared cost / error function
    # First use matrix multiplication and vector subtracton to find errors
    errors = (@x * @theta) - @y

    # Then square all errors
    errors = errors.map { |e| e * e  }

    # Find the mean of the square errors
    mean_square_error = 0.5 * (errors.inject{ |sum, e| sum + e }.to_f / errors.row_size)

    return mean_square_error
  end

  def train_normal_equation
    # Calculate the optimal theta using the normal equation
    # theta = ( X' * X )^1 * X' * y
    @theta = (@x.transpose * @x).inverse * @x.transpose * @y

    return @theta
  end

  def predict data

    # normalize
    data.each_index do |i|
      data[i] = (data[i] - @mu[i]) / @sigma[i].to_f
    end

    # add 1 column to prediction data
    data = [1].concat( data )

    # perform prediction
    prediction = (Matrix[data] * @theta)[0,0].to_f

  end

  private
    def normalize_data x_data

      row_size = x_data.size
      column_count = x_data[0].is_a?( Array) ? x_data[0].size : 1

      x_norm = Array.new(row_size)
      @mu = Array.new(column_count)
      @sigma = Array.new(column_count)

      0.upto(column_count - 1) do |column|
        column_data = x_data.map{ |e| e[column] }
        @mu[column] = column_data.inject{ |sum, e| sum + e } / row_size
        @sigma[column] = column_data.max - column_data.min
      end

      0.upto(row_size -1) do |row|
        row_data = x_data[row]
        x_norm[row] = Array.new(column_count)
        row_data.each_index do |i|
          x_norm[row][i] = (row_data[i] - @mu[i]) / @sigma[i].to_f
        end
      end

      return x_norm

    end

end
