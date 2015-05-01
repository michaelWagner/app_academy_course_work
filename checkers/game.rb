# require_relative 'keypress'
require_relative 'checker_board'

class Game
  attr_reader :white_player, :red_player, :current_player

  def initialize(white_player, red_player)
    @white_player = white_player
    @red_player = red_player
    @current_player = @white_player
    @board = CheckerBoard.new
  end

  def play
    loop do
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
  def initialize(color)
    @color = color
  end

  def make_move
    puts "Would you like to jump or slide? "
    kind_of_move = gets.chomp.downcase
    puts "Where would you like to move to? ("x y")"
    move_to = gets.chomp.split(' ')
    p move_to
    return [kind_of_move, move_to]
  end
end

if __FILE__ == $PROGRAM_NAME
  p1 = Player.new(:white)
  p2 = Player.new(:red)

  game = Game.new(p1, p2)
  game.play

end
