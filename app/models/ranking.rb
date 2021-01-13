class Ranking < ApplicationRecord
	belongs_to :player
	belongs_to :ranking_import
	#validates :utr_player_id, uniqueness: true


end
