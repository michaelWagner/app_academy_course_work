require_relative "chessboard"

class Game

  def initialize(white, black)
    @white, @black = white, black
    @game = ChessBoard.new
    @current_player = @white

  end

  def play
    until @game.checkmate?(@current_player.color)
      begin
        system "clear"
        @game.display
        puts "#{@current_player.color}'s turn"
        user_from, user_to = @current_player.play_turn
        if valid_input?(user_from, user_to)
          @game.move(user_from, user_to)
          @current_player = [@white, @black].reject {|c| c == @current_player }[0]
        else
          raise InvalidMoveError
        end
      rescue
        retry
      end
    end

    puts "#{current_player} loses."
  end

  def valid_color?(from_pos)
    unless from_pos.color != @current_player.color
      puts "This piece is not your color, please select again."
      return false
    end

    true
  end

  def valid_input?(user_from, user_to)
    if valid_position?(@game[user_from]) && valid_color?(@game[user_from])
      return true
    end

    false
  end

  def valid_position?(from_pos)
    if from_pos.nil?
      puts "No player at position #{from_pos} to move."
      return false
    end

    true
  end
end


class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end
end


class HumanPlayer < Player

  def initialize(color)
    super
  end

  def play_turn
    puts "Where do you want to move from "
    user_from = gets.chomp.split(' ').map(&:to_i)
    puts "Where do you want to move the piece to"
    user_to = gets.chomp.split(' ').map(&:to_i)

    [user_from, user_to]
  end
end


if __FILE__ == $PROGRAM_NAME

  p1 = HumanPlayer.new(:white)
  p2 = HumanPlayer.new(:black)
  new_game = Game.new(p1, p2)
  new_game.play
end
