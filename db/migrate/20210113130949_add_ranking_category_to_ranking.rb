class AddRankingCategoryToRanking < ActiveRecord::Migration[6.0]
  def change
  	
  	add_column :rankings, :ranking_category, :string
  end
end
