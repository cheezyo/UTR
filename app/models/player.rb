class Player < ApplicationRecord


	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			Player.create! row.to_hash
		end	
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
