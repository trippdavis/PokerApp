class Hand < ActiveRecord::Base
  validates_presence_of :cards, :player_id, :hand_type
  after_initialize :parse_card_string
  attr_accessor :card_values, :card_suits, :hand_value

  belongs_to :player

  def parse_card_string
    cards_array = self.cards.split(" ")
    @card_values = [];
    @card_values_counts = {};
    @card_suits = [];
    cards_array.each do |card|
      value = card_value(card[0..-2])
      @card_values << card_value(value)

      if @card_values_counts[value]
        @card_values_counts[value] += 1
      else
        @card_values_counts[value] = 1
      end

      @card_values_counts
      @card_suits << card[-1]
    end
    @card_values.sort!

    self.find_duplicate_values
    hand_type = self.determine_type
    @hand_value = hand_type[0]
    self.hand_type = hand_type[1]
  end

  def find_duplicate_values
    @pairs = []
    @trips = []
    @quads = []
    @card_values_counts.each do |val, count|
      case count
      when 2
        @pairs << val
      when 3
        @trips << val
      when 4
        @quads << val
      end
    end
    @pairs.sort!
  end

  def card_value(val)
    if val.to_i > 0
      return val.to_i
    elsif val == "J"
      return 11
    elsif val == "Q"
      return 12
    elsif val == "K"
      return 13
    else
      return 14
    end
  end

  def determine_type
    if @quads.length == 1
      return [7, "Four of a Kind"]
    elsif @trips.length == 1
      return (@pairs.length == 1 ? [6, "Full House"] : [3, "Three of a Kind"])
    elsif @pairs.length == 2
      return [2, "Two Pair"]
    elsif @pairs.length == 1
      return [1, "Pair"]
    end
    straight = (@card_values[1] - @card_values[0] == 1 &&
      @card_values[2] - @card_values[1] == 1 &&
      @card_values[3] - @card_values[2] == 1 &&
      @card_values[4] - @card_values[3] == 1
    )
    flush = (@card_suits[1] == @card_suits[0] &&
      @card_suits[2] == @card_suits[1] &&
      @card_suits[3] == @card_suits[2] &&
      @card_suits[4] == @card_suits[3]
    )

    if (straight && flush)
      return (@card_values[-1] == 14 ? [9, "Royal Flush"] : [8, "Straight Flush"])
    elsif straight
      return [4, "Straight"]
    elsif flush
      return [5, "Flush"]
    end

    [0, "High Card"]
  end



  def <=>(other)

  end
end
