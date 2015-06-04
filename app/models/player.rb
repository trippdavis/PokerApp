class Player < ActiveRecord::Base
  has_many :hands
  has_many :rounds_won, class_name: "Round", foreign_key: :winner_id
end
