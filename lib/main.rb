class Game
  attr_accessor :board
  def initialize
    @board = Array.new(6) { Array.new(7) { 'x' } }
  end

  def clear
    @board = Array.new(6) { Array.new(7) { 'x' } }
  end

  def drop_disc(col_no, sign, possible_row = nil)
    5.downto(0) {|i| possible_row = i and break if board[i][col_no] == 'x' }
    possible_row.nil? ? (puts 'This column is full') : (@board[possible_row][col_no] = sign)
  end

  def four_in_row_horizontally?(current_pos, sign, queue = [], no_of_success = 0, history = [])
    # implemented using BFS
    queue.push(current_pos)
    until queue.empty? || no_of_success == 4
      history.push(current = queue.shift)
      left = [current[0], current[1] - 1]
      right = [current[0], current[1] + 1]
      no_of_success += 1
      # adding left node if possible
      queue.push(left) if is_valid?(left, history, sign)
      queue.push(right) if is_valid?(right, history, sign)
    end
    no_of_success.eql?(4) ? true : false
  end

  def four_in_row_diagnolly?(current_pos, sign, queue = [], no_of_success = 0, history = [])
    # implemented using BFS
    queue.push(current_pos)
    until queue.empty? || no_of_success == 4
      history.push(current = queue.shift)
      left = [current[0] + 1, current[1] - 1]
      right = [current[0] - 1, current[1] + 1]
      no_of_success += 1
      # adding left node if possible
      queue.push(left) if is_valid?(left, history, sign)
      queue.push(right) if is_valid?(right, history, sign)
    end
    no_of_success.eql?(4) ? true : false
  end

  def four_in_row_vertically?(current_pos, sign, queue = [], no_of_success = 0, history = [])
    # implemented using BFS
    queue.push(current_pos)
    until queue.empty? || no_of_success == 4
      history.push(current = queue.shift)
      # in this case, left would be up, right would be down
      left = [current[0] - 1, current[1]]
      right = [current[0] + 1, current[1]]
      no_of_success += 1
      # adding left node if possible
      queue.push(left) if is_valid?(left, history, sign)
      queue.push(right) if is_valid?(right, history, sign)
    end
    no_of_success.eql?(4) ? true : false
  end

  def four_in_row(current_pos, sign, direction, queue = [], no_of_success = 0, history = [])
    # implemented using BFS
    queue.push(current_pos)
    until queue.empty? || no_of_success == 4
      history.push(current = queue.shift)
      no_of_success += 1
      left = [current[0], current[1] - 1] and right = [current[0], current[1] + 1] if direction == 'x'
      left = [current[0] + 1, current[1] - 1] and right = [current[0] - 1, current[1] + 1] if direction == 'z'
      left = [current[0] - 1, current[1]] and right = [current[0] + 1, current[1]] if direction == 'y'
      # adding left and right node if possible
      queue.push(left) if is_valid?(left, history, sign)
      queue.push(right) if is_valid?(right, history, sign)
    end
    no_of_success.eql?(4) ? true : false
  end

  def is_valid?(pos, history, sign)
    # also the sign/disc should match
    return false unless pos[0].between?(0,5) and pos[1].between?(0,5)
    return false unless @board[pos[0]][pos[1]] == sign
    return false if history.include?(pos)
    true
  end
end

# misc: 🟡 , 🔴
game = Game.new
