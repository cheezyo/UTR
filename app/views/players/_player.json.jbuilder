json.extract! player, :id, :utr_player_id, :name, :birthdate, :birthyear, :member_id, :ranking_category, :utr, :reliability, :profil_link, :created_at, :updated_at
json.url player_url(player, format: :json)
