require_relative 'card'
require_relative 'deck'

class Hand
  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def evaluate
    case cards
    when flush? && royal?
      puts "Royal Flush"
    when flush? && straight?
      puts "Straight Flush"
    when four_of_a_kind?
      puts "Four of a Kind"
    when full_house?
      puts "Full House"
    when flush?
      puts "Flush"
    when straight?
      puts "Straight"
    when three_of_a_kind?
      puts "Three of a kind"
    when two_pair?
      puts "Two pair"
    when pair?
      puts "Pair"
    when high_card?
      puts "High Card"
    end
  end

  def royal?
    # @cards.values.include?()
  end

  def flush?

  end

  def straight?

  end

  def of_a_kind?

  end

  def high_card?

  end
