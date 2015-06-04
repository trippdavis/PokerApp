class CreateRoundHands < ActiveRecord::Migration
  def change
    create_table :round_hands do |t|
      t.integer :round_id, null: false
      t.integer :hand_id, null: false

      t.timestamps null: false
    end
  end
end
