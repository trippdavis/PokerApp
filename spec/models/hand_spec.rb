require 'rails_helper'

RSpec.describe Hand, type: :model do
  let(:hand) {Hand.create(cards: "AC 5D 3S 3C 6D", player_id: 1)}
  let(:royal_flush_hand) {Hand.create!(cards: "AC JC QC 10C KC", player_id: 1)}
  let(:straight_flush_hand) {Hand.create(cards: "4D 5D 3D 7D 6D", player_id: 1)}
  let(:four_of_a_kind_hand) {Hand.create(cards: "AC 3D 3S 3C 3H", player_id: 1)}
  let(:full_house_hand) {Hand.create(cards: "5S 5D 3S 3C 3H", player_id: 1)}
  let(:flush_hand) {Hand.create(cards: "7D 5D 2D JD 6D", player_id: 1)}
  let(:straight_hand) {Hand.create(cards: "5C 4D 3S 7C 6D", player_id: 1)}
  let(:three_of_a_kind_hand) {Hand.create(cards: "3H 5D 3S 3C 6D", player_id: 1)}
  let(:two_pair_hand) {Hand.create(cards: "AC AD 3S 6C 6D", player_id: 1)}
  let(:pair_hand) {Hand.create(cards: "5C 5D JS 3C 6D", player_id: 1)}
  let(:high_card_hand) {Hand.create(cards: "AC 5D 3S KC 6D", player_id: 1)}

  describe "card_value" do
    it "determines the correct value of a number card" do
      expect(hand.card_value("2")).to eq(2)
    end

    it "determines the correct value of a face card" do
      expect(hand.card_value("Q")).to eq(12)
    end

    it "determines the correct value of an ace" do
      expect(hand.card_value("A")).to eq(14)
    end
  end

  describe "parse_card_string" do
    it "sorts hand values" do
      hand.parse_card_string
      expect(hand.card_values).to eq([3, 3, 5, 6, 14])
    end

    it "populates hand suits" do
      hand.parse_card_string
      expect(hand.card_suits).to include("C", "C", "D", "D", "S")
    end
  end

  describe "determine type" do
    it "determines a royal flush" do
      expect(royal_flush_hand.hand_type).to eq("Royal Flush")
    end

    it "determines a straight flush" do
      expect(straight_flush_hand.hand_type).to eq("Straight Flush")
    end

    it "determines 4 of a kind" do
      expect(four_of_a_kind_hand.hand_type).to eq("Four of a Kind")
    end

    it "determines a full house" do
      expect(full_house_hand.hand_type).to eq("Full House")
    end

    it "determines a flush" do
      expect(flush_hand.hand_type).to eq("Flush")
    end

    it "determines a straight" do
      expect(straight_hand.hand_type).to eq("Straight")
    end

    it "determines 3 of a kind" do
      expect(three_of_a_kind_hand.hand_type).to eq("Three of a Kind")
    end

    it "determines two pair" do
      expect(two_pair_hand.hand_type).to eq("Two Pair")
    end

    it "determines pair" do
      expect(pair_hand.hand_type).to eq("Pair")
    end

    it "determines high card" do
      expect(high_card_hand.hand_type).to eq("High Card")
    end
  end

  describe "hand comparison (<=>)" do
    it "works for different hand types" do
      expect(high_card_hand <=> pair_hand).to eq(-1)
      expect(three_of_a_kind_hand <=> full_house_hand).to eq(-1)
      expect(royal_flush_hand <=> straight_flush_hand).to eq(1)
      expect(straight_hand <=> two_pair_hand).to eq(1)
    end
  end
end
