relative_require "chessboard"
relative_require "pieces"

class Game

  def initialize(white, black)
    @white, @black = white, black
  end

end


class Player

  def initialize(color)
    @color = color
  end

end
