require_relative 'pieces'
require 'byebug'

class InvalidMoveError < StandardError
end

class ChessBoard
  PIECE_ORDER = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  attr_accessor :board

  def initialize(fill_pieces = true)
    @board = create_board
    @fill_pieces = fill_pieces
    fill_board
  end

  def all_pieces
    @board.flatten.compact
  end

  def board_dup
    dup_board = ChessBoard.new(false)
    all_pieces.each do |piece|
      dup_piece = piece.dup(dup_board)
      dup_board[dup_piece.position] = dup_piece
    end

    dup_board
  end

  def checkmate?(color)
    checkmate = false
    if self.in_check?(color)
      pieces(color).all? do |piece|
        piece.valid_moves.count == 0
        checkmate = true
      end
    end

    checkmate
  end

  def create_board
    Array.new(8) { Array.new(8) }
  end

  def fill_board
    if @fill_pieces == true
      # Fill black pawns
      @board[1].each_with_index do |tile, i|
        self[[1, i]] =  Pawn.new(self, [1, i], :black)
      end

      # Fill white pawns
      @board[6].each_with_index do |tile, i|
        self[[6, i]]=  Pawn.new(self, [6, i], :white)
      end

      PIECE_ORDER.each_with_index do |piece, i|
        [[0, :black], [7, :white]].each do |row_number, color|
          self[[row_number, i]] = piece.new(self, [row_number, i], color)
        end
      end
      # nil
    end
  end


  def display
    print "\n"
    (0..7).each do |row|
      (0..7).each do |col|
        tile = self[[row, col]]
        if tile.nil?
          print "  * "
        else
          print "  #{tile.symbol} "
        end
      end
      print "\n\n"
    end
    nil
  end

  def pieces(color)
    all_pieces.select { |piece| piece.color == color }
  end

  def in_check?(color)
    enemy_color = [:white, :black].reject {|c| c == color }[0]
    our_king = king(color)
    pieces(enemy_color).each do |piece|
      piece.moves.each do |move|
        if move == our_king.position
          return true
        end
      end
    end

    return false
  end

  def king(color)
    pieces(color).find { |piece| piece.is_a?(King) }
  end

  def find_kings
    kings = []
    @board.each do |row|
      row.each do |tile|
        if tile.is_a?(King)
          kings << tile
        end
      end
    end

    kings
  end

  def [](pos)
    row, col = pos
    self.board[row][col]
  end

  def []=(pos, value)
    row, col = pos
    self.board[row][col] = value
  end

  def move(starting_position, ending_position)
    # debugger
    piece = self[starting_position]
    raise NoPieceError if piece.nil?

    if piece.valid_moves.include?(ending_position)
      piece.position = ending_position
      self[starting_position] = nil
      self[ending_position] = piece
      piece.moved = true
      display
    else
      # catch in game.rb
      raise InvalidMoveError
    end
    display
  end

  def move!(starting_position, ending_position)
    # test_board = board_dup
    from = self[starting_position]
    self[ending_position] = from
    self[starting_position] = nil
    self[ending_position].position = ending_position
  end
end


if __FILE__ == $PROGRAM_NAME
  c = ChessBoard.new

  # Quick checkmate


  c.move([1, 4], [2, 4])
  c.move([1, 5], [3, 5])
  c.move([6, 4], [4, 4])
  c.move([7, 3], [3, 7])
  p c.checkmate?(:black)

  # c.move([1, 1], [2, 1])
  # c.move([0, 1], [5, 0])
  # c.move([0, 1], [2, 2])
  # p c[[2, 1]].moves
  # c.move([1, 3], [3, 3])

  # c.move([0,1], [2,2])
  # p1 = Rook.new(x, [0,0], :white)
  # p p1.move_into_
end
