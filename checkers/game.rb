require_relative 'checker_board'
# require_relative 'keypress'

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
    until game_over?
      @board.render
      @current_player.make_move
      update_current_player
    end
  end

  def update_current_player
    if @current_player == @white_player
      @current_player = @red_player
    else
      @current_player = @white_player
    end
  end
end

class Player
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

  def make_move
    puts "Enter the piece you would like to move \"[x, y]\": "
    puts "Would you like to jump or slide? "
    puts "Enter where you'd like to move the piece \"[x, y]\": "

    from_pos, action, to_pos = gets.chomp.split(' ')

    from_pos = [from_pos[1].to_i, from_pos[3].to_i]
    to_pos = [to_pos[1].to_i, to_pos[3].to_i]

    # p from_pos, action, to_pos

    if action == 'j'
      @board[from_pos].perform_jump(to_pos)
    elsif action == 's'
      @board[from_pos].perform_slide(to_pos)
    else
      raise "Invalid action"
    end

    system 'clear'
  end
end

if __FILE__ == $PROGRAM_NAME
  # p1 = Player.new(:white)
  # p2 = Player.new(:red)

  game = Game.new
  game.play

end
