class Hand < ActiveRecord::Base
  validates_presence_of :cards
  before_save :parse_cards
  attr_accessor :card_values, :card_suits, :type

  def parse_cards
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
    @type = self.determine_type
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
      return "Four of a Kind"
    elsif @trips.length == 1
      return (@pairs.length == 1 ? "Full House" : "Three of a Kind")
    elsif @pairs.length == 2
      return "Two Pair"
    elsif @pairs.length == 1
      return "Pair"
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
      return (@card_values[-1] == 14 ? "Royal Flush" : "Straight Flush")
    elsif straight
      return "Straight"
    elsif flush
      return "Flush"
    end

    "High Card"
  end



end
