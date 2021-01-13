class AddBirthyearToRank < ActiveRecord::Migration[6.0]
  def change
    add_column :rankings, :birthyear, :integer
  end
end
