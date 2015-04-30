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
        if validate_input(user_from, user_to)

          @game.move(user_from, user_to)
          @current_player = [@white, @black].reject {|c| c == @current_player }[0]
        else
          raise InvalidMoveError
        end
      rescue
        puts "That's an invalid move, please try again: "
        retry
      end
    end

    puts "#{current_player} loses."
  end

# split into 2 types of validations
# color
# nil
  def validate_input(user_from, user_to)
    unless @game[user_from].color != @current_player.color || @game[user_from].nil?
      # raise InvalidMoveError
    # end
  # rescue InvalidMoveError => e
  #   puts "That was an invalid move."
  #   puts "#{e.message}"

      return false
    end

    return true
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
