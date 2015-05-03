require_relative 'hand'
require_relative 'deck'

class Player
  attr_accessor :hand, :bankroll

  def initialze(hand, bankroll)
    @hand = hand
    @bankroll
  end
end
