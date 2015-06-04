class Round < ActiveRecord::Base
  belongs_to :winner, class: "Player", foreign_key: :winner_id

  def determine_winner
  end



end
