require_relative 'checker_board'
require_relative 'keypress'

class Game
  attr_reader :white_player, :red_player, :current_player

  def initialize
    @board = CheckerBoard.new
    @white_player = Player.new(:white, @board)
    @red_player = Player.new(:red, @board)
    @current_player = @red_player
  end

  def game_over?
    # when a player has no more pieces or no moves available game is over.
    # puts "@white_player.available_moves: #{@white_player.available_moves.count}"
    # puts "@red_player.available_moves: #{@red_player.available_moves.count}"

    return @white_player.available_moves.count <= 0 || @red_player.available_moves.count <= 0
  end

  def play
    system 'clear'
    @board.render
    puts "Welcome to checkers!"
    puts "Please use the cursor to first select a piece "
    puts "and then select where to place it."
    puts "It is the red player's turn."
    until game_over?
      begin
        @current_player.make_move
      rescue
        puts "Invalid"
        retry
      end
      update_current_player
    end
  end

  def update_current_player
    if @current_player == @white_player
      puts "It is the red player's turn."
      @current_player = @red_player
    else
      puts "It is the white player's turn."
      @current_player = @white_player
    end
  end
end

class Player
  attr_reader :color

  def initialize(color, board)
    @color = color
    @board = board
    @pieces = []
  end

  def available_moves
    moves = []
    @board.pieces(@color).each do |piece|
      moves << piece.possible_slides + piece.possible_jumps
    end

    moves
  end

  def jump_move?(from_pos, to_pos)
    from_x, from_y = from_pos
    to_x, to_y = to_pos

    return (from_x - to_x).abs == 2 && (from_y - to_y).abs == 2
  end

  def make_move
    # puts "Enter the piece you would like to move \"[x, y]\": "
    # puts "Would you like to jump or slide? "
    # puts "Enter where you'd like to move the piece \"[x, y]\": "
    seq = []
    last_pos = [-1, -1]
    until seq.count > 1 && seq[-2] == last_pos
      last_pos = @board.move_cursor
      seq << last_pos
      if @board[seq[0]].color != color
        raise "Please move your own piece."
      end
    end

    seq = seq[0...-1]

    p "sequence: #{seq}"

    # if seq.count == 2
      from_pos = seq.shift
      until seq.empty?
        to_pos = seq.shift
        p "from_pos: #{from_pos}"
        p "to_pos: #{to_pos}"

        p move(from_pos, to_pos)
        from_pos = to_pos

      end

    system 'clear'
    @board.render
  end

  def move(from_pos, to_pos)
    # p to_pos.count
    # to_pos.each do

    jump_move?(from_pos, to_pos) ? @board[from_pos].perform_jump(to_pos) :
                                   @board[from_pos].perform_slide(to_pos)
  end
end

if __FILE__ == $PROGRAM_NAME

  game = Game.new
  game.play

end
