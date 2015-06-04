class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :winner_id

      t.timestamps null: false
    end

    add_index :rounds, :winner_id
  end
end
