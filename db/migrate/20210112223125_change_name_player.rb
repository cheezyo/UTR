class ChangeNamePlayer < ActiveRecord::Migration[6.0]
  def change
  	rename_column :players, :profil_link, :profile_link
  end
end
