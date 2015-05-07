require_relative 'card'

class Deck
  def self.all_cards
    cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(suit, value)
      end
    end

    cards
  end

  def initialize(cards = Deck.all_cards)
    @deck = cards
  end

  def count
    @deck.count
  end

  def take(n)
    if n > count
      raise "not enough cards"
    else
      taken = []
      n.times do
        taken << @deck.shift
      end

      taken
    end
  end

  def return(cards)
    @deck << cards
    @deck.flatten!
  end
end
