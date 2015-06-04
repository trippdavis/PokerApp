class CreateHands < ActiveRecord::Migration
  def change
    create_table :hands do |t|
      t.string :cards, null: false

      t.timestamps null: false
    end
  end
end
