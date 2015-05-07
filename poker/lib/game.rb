require_relative 'player'

class Game
  attr_reader :players, dealer

  def initialize(players, dealer)
    @players = []
    @dealer = dealer
  end
end
