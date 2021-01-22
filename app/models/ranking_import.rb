class RankingImport < ApplicationRecord
	has_many :rankings, dependent: :destroy



	def self.import(file, rank_id)
		utr_ids = RankingImport.find(rank_id.to_i).rankings.pluck(:utr_player_id)
		CSV.foreach(file.path, headers: true) do |row|

			unless utr_ids.include?(row["utr_player_id"].to_i)
				rank = Ranking.new 
				rank.ranking_import_id = rank_id.to_i
				rank.utr = row["utr"]
				rank.reliability = row["reliability"]
				rank.utr_player_id = row["utr_player_id"]
				rank.ranking_category = row["ranking_category"]
				rank.birthyear = row["birthyear"]
				id = ""
				player = Player.find_by_utr_player_id(row["utr_player_id"])
				if player.nil?
					p = Player.create! row.to_hash
					change_name(p)
					id = p.id
				else
					id = player.id
					
				end
				rank.player_id = id
				rank.save

				#ranking = .find_by_utr_player_id(row["utr_player_id"]) || new
				#player.update_attributes(row.to_hash)
				#player.save
			end
		end
	
	end
	def self.change_name(player)	
	p_name = Array.new
	p = player
		p.name.split(" ").each do |a| 
			if a.include?("-")
				arr = a.split("-")
				(1..arr.count).each do |i| 
					arr[i-1].capitalize
				end
				p_name << arr.join("-")
			else
				p_name << a.capitalize
			end
		end
		p.name = p_name.join(" ")
		p.save
		

end
end
