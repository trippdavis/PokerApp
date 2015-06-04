class RoundHand < ActiveRecord::Base
  validates_presence_of :round_id, :hand_id
  belongs_to :round
  belongs_to :hand
end
