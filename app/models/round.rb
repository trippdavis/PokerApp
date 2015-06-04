class Round < ActiveRecord::Base
  has_many :hands
  belongs_to :winner, class: "Player", foreign_key: :winner_id

  def determine_winner
    hand_values = { "High Card" => 0, "Pair" => 1, "Two Pair" => 2,
      "Three of a Kind" => 3, "Straight" => 4, "Flush" => 5,
      "Full House" => 6, "Four of a Kind" => 7, "Straight Flush" => 8,
      "Royal Flush" => 9 }

    


  end


end
