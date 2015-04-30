module Slideable
  def sliding_moves(delta, position)
    x, y = position
    possible_moves = []

    delta.each do |possible_direction|
      temp_x, temp_y = x, y
      shift_x, shift_y = possible_direction

      until !temp_x.between?(0, 7) || !temp_y.between?(0,7)
        check_x, check_y = [temp_x + shift_x, temp_y + shift_y]
        if check_x.between?(0,7) && check_y.between?(0,7)
          if team_collision([check_x, check_y])
            break
          else
            possible_moves << [check_x, check_y]
          end
        end
        temp_x, temp_y = [check_x, check_y]
      end
    end

    possible_moves
  end
end

module Stepable
  def stepping_moves(delta, position)
    x, y = position
    possible_moves = []

    delta.each do |possible_direction|
      temp_x, temp_y = x, y
      shift_x, shift_y = possible_direction
      check_x, check_y = [temp_x + shift_x, temp_y + shift_y]

      if check_x.between?(0,7) && check_y.between?(0,7)
        unless team_collision([check_x, check_y])
          possible_moves << [check_x, check_y]
        end
      end
    end

    possible_moves
  end


end

class Piece
  attr_reader :color, :board
  attr_accessor :position, :moved

  def initialize(board, position, color, moved = false)
    @board = board
    @position = position
    @color = color
    @moved = moved
  end

  def dup(board)
    self.class.new(board, @position.dup, @color)
  end

  def inspect
    symbol
  end

  def move_into_check?(ending_position)
    dup_board = @board.board_dup
    starting_position = @position.dup

    # check the move
    dup_board.move!(starting_position, ending_position)
    #
    # from = dup_board[starting_position]
    # dup_board[ending_position] = from
    # dup_board[starting_position] = nil

    dup_board.in_check?(@color)
  end

  def team_collision(pos)
    unless @board[pos].nil?
      @board[pos].color == @color
    end
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

end

class SlidingPiece < Piece
  include Slideable
  def initialize(board, position, color, moved = false)
    super
  end

  def moves
    delta = directions
    sliding_moves(delta, @position)
  end
end

class SteppingPiece < Piece
  include Stepable
  def initialize(board, position, color, moved = false)
    super
  end

  def moves
    delta = directions
    stepping_moves(delta, @position)
  end
end

class Bishop < SlidingPiece
  def initialize(board, position, color, moved = false)
    super
  end

  def symbol
    @color == "black" ? "\u265D" : "\u2657"
  end


  def directions
    [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  end

end

class Rook < SlidingPiece
  def initialize(board, position, color, moved = false)
    super
  end

  def directions
    [[0, 1], [1, 0], [0, -1], [-1, 0]]
  end

  def symbol
    @color == "black" ? "\u265c" : "\u2656"
  end
end

class Queen < SlidingPiece
  def initialize(board, position, color, moved = false)
    super
  end

  def directions
    [[-1, -1], [-1, 1], [1, -1], [1, 1], [0, 1], [1, 0], [0, -1], [-1, 0]]
  end

  def symbol
    @color == "black" ? "\u265b" : "\u2655"
  end
end

class Knight < SteppingPiece
  def initialize(board, position, color, moved = false)
    super
  end

  def directions
    [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
     [1, -2], [1, 2], [2, -1], [2, 1]]
  end

  def symbol
    @color == "black" ? "\u265e" : "\u2658"
  end

end

class King < SteppingPiece
  def initialize(board, position, color, moved = false)
    super
  end

  def directions
    [[-1, -1], [-1, 1], [1, -1], [1, 1],
     [0, 1], [1, 0], [0, -1], [-1, 0]]
  end

  def symbol
    @color == "black" ? "\u265a" : "\u2654"
  end

end

class Pawn < SteppingPiece
  def initialize(board, position, color, moved = false)
    super
  end

  # refactor
  def directions
    x, y = @position
    if @color == :black
      valid_directions = [[1, 0]]
      unless @moved
        valid_directions << [2, 0]
      end

      [[1, -1], [1, 1]].each do |temp_x, temp_y|
        check_x, check_y = x + temp_x, y + temp_y
        if check_x.between?(0, 7) && check_y.between?(0, 7)
          if @board[[check_x, check_y]].is_a?(Piece)
            unless @board[[check_x, check_y]].color == @color
              valid_directions << [temp_x, temp_y]
            end
          end
        end
      end

    else
      valid_directions = [[-1, 0]]
      unless @moved
        valid_directions << [-2, 0]
      end

      [[-1, -1], [-1, 1]].each do |temp_x, temp_y|
        check_x, check_y = x + temp_x, y + temp_y
        if check_x.between?(0, 7) && check_y.between?(0, 7)
          if @board[[check_x, check_y]].is_a?(Piece)
            unless @board[[check_x, check_y]].color == @color
              valid_directions << [temp_x, temp_y]
            end
          end
        end
      end

    end

    valid_directions
  end

  def symbol
    @color == "black" ? "\u265f" : "\u2659"
  end

end
