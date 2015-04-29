require_relative 'pieces'

class ChessBoard
  PIECE_ORDER = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]
  attr_accessor :board

  def initialize
    @board = create_board
    fill_board
    @white_turn = true
  end

  def create_board
    Array.new(8) { Array.new(8) }
  end

  def fill_board
    # Fill black pawns
    @board[1].each_with_index do |tile, i|
      @board[1][i] =  Pawn.new(@board, [1, i], "black")
    end

    # Fill white pawns
    @board[6].each_with_index do |tile, i|
      @board[6][i] =  Pawn.new(@board, [6, i], "white")
    end

    PIECE_ORDER.each_with_index do |piece, i|
      [[0, "black"], [7, "white"]].each do |row_number, color|
        # attributes = [@board, [row_number, i], color]
        @board[row_number][i] = piece.new(@board, [row_number, i], color)
      end
    end
    nil
    display
  end

  def display
    print "\n"
    (0..7).each do |row|
      (0..7).each do |col|
        tile = @board[row][col]
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

    # @board.each do |row|
    #   puts row
    # end
  # end

  # refactor
  def in_check?
    current_kings = find_kings
    self.board.each do |row|
      row.each do |tile|
        if !tile.nil?
          piece = tile
          # puts piece
          enemy_king = current_kings.reject { |king| king.color == piece.color }[0]
          if piece.valid_moves.include?(enemy_king)
            return true
          end
        end
      end
    end
    return false
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

  def [](row, col)
    @board[row][col]
  end

  def []=(row, col, ending)
    @board[row][col] = ending
  end

  def move(starting_position, ending_position)
    piece = self[starting_position[0], starting_position[1]]
    raise NoPieceError if piece.nil?

    # check if pieces can move onto enemy piece or nil

    # raise InvalidMoveError if !@board[ending].nil?

    # piece.valids_moves.each do |move|

    test_board = board_copy(@board)
    test_board[piece.position[0], piece.position[1]] = nil
    piece.position = ending_position
    test_board[piece.position[0], piece.position[1]] = piece
    # raise InvalidMoveError if test_board.in_check?

    @board[piece.position[0], piece.position[1]] = nil
    piece.position = ending_position
    @board[piece.position[0], piece.position[1]] = piece

  end

  def board_copy(board)
    board.inject([]) do |board, tile|
      board << (tile.is_a?(Array) ? board_copy(tile) : tile)
    end
  end


# AI Territory
  # black is in check
  # black's turn
  # able_to_move = [black's king]
  # iterate through black's pieces and see if any
  # to cross the valids_moves of  the white attacker
  # if so add to able_to_move

end

#
# c = ChessBoard.new

# c.display
