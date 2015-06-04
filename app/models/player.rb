class Player < ActiveRecord::Base
  has_many :hands
  has_many :rounds_won, class: "Round", foreign_key: :winner_id
end
