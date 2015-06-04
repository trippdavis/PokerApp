class Round < ActiveRecord::Base
  belongs_to :winner, class: "Player", foreign_key: :winner_id
  has_many: :round_hands
  has_many: :hands, through: :round_hands, source: :hand

  def determine_winner
  end
end
