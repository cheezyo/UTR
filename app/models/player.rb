class Player < ApplicationRecord
	has_many :rankings

def rank
	RankingImport.all.order(rank_date: :desc).each do |a|
		if a.rankings.pluck(:utr_player_id).include?(self.utr_player_id)
			return a.rankings.find_by_utr_player_id(self.utr_player_id).utr
			break
		end
	end	
end
def self.import(file)
	CSV.foreach(file.path, headers: true) do |row|
		#Player.create! row.to_hash
		player = Player.find_by_utr_player_id(row["utr_player_id"]) || new
		player.update_attributes(row.to_hash)
		player.save
	end
	change_name	
end

def self.change_name

	
	
	p_name = Array.new
	Player.all.each do |p|
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
		p_name = Array.new
	end
end


end
