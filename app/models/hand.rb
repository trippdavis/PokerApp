class Hand < ActiveRecord::Base
  validates_presence_of :cards, :player_id, :hand_type
  after_initialize :parse_card_string
  attr_accessor :card_values, :card_suits, :hand_value, :pairs, :trips, :quads

  belongs_to :player
  has_one :hand_round
  has_one :round, through: :hand_round, source: :round

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
    case @hand_value <=> other.hand_value
    when 1
      return 1
    when -1
      return -1
    when 0
      if ["Royal Flush", "Straight Flush", "Straight", "High Card", "Flush"].include?(hand_type)
        return @card_values.reverse <=> other.card_values.reverse
      elsif ["Three of a Kind", "Full House"].include?(hand_type)
        return @trips <=> other.trips
      elsif ["Two Pair", "Pair"].include?(hand_type)
        case @pairs.reverse <=> other.pairs.reverse
        when -1
          return -1
        when 1
          return 1
        when 0
          return @card_values <=> other.card_values
        end
      else
        return @quads <=> other.quads
      end
    end
  end
end
