require 'hand'

describe Hand do
  describe "#compare_hands" do
    hand = Hand.new([
      Card.new(:spades, :ten),
      Card.new(:spades, :jack)
      Card.new(:spades, :queen),
      Card.new(:spades, :king)
      Card.new(:spades, :ace)
    ])
    other_hand = Hand.new([
      Card.new(:spades, :ace),
      Card.new(:spades, :duece)
      Card.new(:spades, :three),
      Card.new(:spades, :four)
      Card.new(:spades, :five)
    ])
    it "should compare two hands and return the winner" do
      expect(hand.compare_hands(other_hand)).to eq(hand)
    end

  describe "#draw_cards" do
    it "should add cards to hand" do
      expect(draw_cards(deck)).to eq()
    end
