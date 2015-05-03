require_relative 'card'
require_relative 'deck'

class Hand
  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def evaluate
    case cards
    when royal_flush?
      puts "Royal Flush"
    when
      straight_flush?
