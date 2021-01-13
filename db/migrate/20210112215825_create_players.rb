class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.integer :utr_player_id
      t.string :name
      t.date :birthdate
      t.integer :birthyear
      t.string :member_id
      t.string :ranking_category
      t.float :utr
      t.integer :reliability
      t.string :profil_link

      t.timestamps
    end
  end
end
