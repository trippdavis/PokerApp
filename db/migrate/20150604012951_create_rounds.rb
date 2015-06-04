class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :player_1_hand_id, null: false
      t.integer :player_2_hand_id, null: false
      t.integer :winner_id, null: false

      t.timestamps null: false
    end

    add_index :rounds, :player_1_hand_id
    add_index :rounds, :player_2_hand_id
    add_index :rounds, :winner_id
  end
end
