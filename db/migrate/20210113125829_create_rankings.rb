class CreateRankings < ActiveRecord::Migration[6.0]
  def change
    create_table :rankings do |t|
      t.integer :player_id
      t.integer :ranking_import_id
      t.float :utr
      t.integer :reliability
      t.integer :utr_player_id

      t.timestamps
    end
  end
end
