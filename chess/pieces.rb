module Slideable
  def sliding_moves(delta, position, board)
    x, y = position
    possible_moves = []

    delta.each do |possible_direction|
      temp_x, temp_y = x, y
      shift_x, shift_y = possible_direction

      until !temp_x.between?(0, 7) || !temp_y.between?(0,7)
        check_x, check_y = [temp_x + shift_x, temp_y + shift_y]
        if check_x.between?(0,7) && check_y.between?(0,7)
          possible_moves << [check_x, check_y]
        end
        temp_x, temp_y = [check_x, check_y]
      end
    end

    possible_moves
  end





  # def valid_move?(end_position, board, position)
  #   # x, y = end_position
  #   # return false if x.between?(0, 7) || y.between?(0,7)
  #   return true if @board[end_position].nil?
  #   return false if @board[end_position].color == @board[position].color
  #   return true
  #
  # end

end

module Stepable
  def stepping_moves(delta, position, board)
    x, y = position
    possible_moves = []

    delta.each do |possible_direction|
      temp_x, temp_y = x, y
      shift_x, shift_y = possible_direction
      check_x, check_y = [temp_x + shift_x, temp_y + shift_y]

      if check_x.between?(0,7) && check_y.between?(0,7)
        possible_moves << [check_x, check_y]
      end
    end

    possible_moves
  end


end

class Piece
  attr_reader :unicode_sym, :color
  attr_accessor :position, :moved

  def initialize(board, position, color, moved = false)
    @board = board
    @position = position
    @color = color
    @moved = moved
    # @unicode_sym = nil
  end

  def board_copy(board)
    board.inject([]) do |board, tile|
      board << (tile.is_a?(Array) ? board_copy(tile) : tile)
    end
  end

  def inspect
    puts "#{@unicode_sym} at position: #{@position}"
  end

  def moves
    directions
  end

  def valid_moves
    filtered_moves = []
    moves.each do |pos|
      filtered_moves << pos unless #move_into_check?(pos)
    end
  end

  def team_collision(pos)
    @board[pos[0], pos[1]] == @color
  end

end

class SlidingPiece < Piece
  include Slideable
  def initialize(board, position, color, moved = false)
    super
  end

  def moves
    delta = directions
    sliding_moves(delta, @position, @board)
  end
end

class SteppingPiece < Piece
  include Stepable
  def initialize(board, position, color, moved = false)
    super
  end

  def moves
    delta = directions
    stepping_moves(delta, @position, @board)
  end
end

class Bishop < SlidingPiece
  def initialize(board, position, color, moved = false)
    super
  end

  def symbol
    @color == "black" ? "\u265D" : "\u2657"
  end

  # def move_into_check?(pos)
  #   check_board = ChessBoard.new
  #   check_board.board = board_copy(@board)
  #   check_board[@position[0], @position[1]] = nil
  #   @position = pos
  #   check_board[pos[0], pos[1]] = self
  #
  #   check_board.in_check?
  # end

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

class Pawn < Piece
  def initialize(board, position, color, moved = false)
    super
  end

  def valid_moves
  end

  def symbol
    @color == "black" ? "\u265f" : "\u2659"
  end

end
