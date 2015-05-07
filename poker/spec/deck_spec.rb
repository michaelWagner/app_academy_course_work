require 'card'
require 'deck'

describe Deck do
  describe "::all_cards" do
    subject(:all_cards) { Deck.all_cards }

    it "should start with 52 cards" do
      expect(all_cards.count).to eq(52)
    end

    it "should not have any duplicate cards" do
      this_deck = all_cards
        .map { |card| [card.suit, card.value] }
        .uniq
        .count
      expect(this_deck).to eq(52)
    end
  end

  let (:cards) do
    cards = [
      Card.new(:clubs, :queen),
      Card.new(:hearts, :king),
      Card.new(:spades, :ace)
    ]
  end

  describe "#initialize" do
    it "creates a deck with 52 cards by default" do
      expect(Deck.new.count).to eq(52)
    end

    it "can be initialized with an array of cards" do
      deck = Deck.new(cards)
      expect(deck.count).to eq(3)
    end
  end

  let(:deck) { Deck.new(cards.dup) }

  it "does not expose it's cards directly" do
    expect(deck).not_to respond_to(:cards)
  end

  describe "#take" do
    it "takes cards from top of deck" do
      expect(deck.take(1)).to eq(cards[0..0])
      expect(deck.take(2)).to eq(cards[1..2])
    end

    it "removes cards from deck on take" do
      deck.take(2)
      expect(deck.count).to eq(1)
    end

    it "doesn't allow you to take more cards than are in the deck" do
      expect do
        deck.take(4)
      end.to raise_error("not enough cards")
    end
  end

  describe "#return" do
    let(:more_cards) do
      [ Card.new(:hearts, :four),
        Card.new(:hearts, :five),
        Card.new(:hearts, :six) ]
    end

    it "returns cards to the deck" do
      deck.return(more_cards)
      expect(deck.count).to eq(6)
    end
  end

end
