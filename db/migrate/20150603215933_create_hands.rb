class CreateHands < ActiveRecord::Migration
  def change
    create_table :hands do |t|
      t.string :cards, null: false
      t.integer :player_id, null: false
      t.integer :round_id, null: false
      t.string :hand_type, null: false
      t.boolean :winner

      t.timestamps null: false
    end

    add_index :hands, :player_id
    add_index :hands, :round_id
  end
end
