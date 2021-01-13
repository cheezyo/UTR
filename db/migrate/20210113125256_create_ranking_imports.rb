class CreateRankingImports < ActiveRecord::Migration[6.0]
  def change
    create_table :ranking_imports do |t|
      t.date :rank_date
      t.string :title

      t.timestamps
    end
  end
end
