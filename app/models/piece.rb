class Piece < ActiveRecord::Base
	belongs_to :game
	
	# method accepts destination coordinates & returns a boolean
	# returning 'true' means there is an obstruction 
	def is_obstructed?(destination_x, destination_y)
		other_piece = game.pieces.where(x_coordinate: destination_x, y_coordinate: destination_y ).first
		if other_piece.present? 
			return true
		end
		
		found = false  # horizontal, already checked destination
		
		(self.x_coordinate + 1).upto(destination_x - 1).each do |x|
			square = game.pieces.where(x_coordinate: x, y_coordinate: destination_y).first
			if square.present? 
				found = true
				break 
			end
		end
		found
	end
end