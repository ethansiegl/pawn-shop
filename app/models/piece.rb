class Piece < ActiveRecord::Base
	belongs_to :game
	
	# method accepts destination coordinates & returns a boolean
	# returning 'true' means there is a piece b/t the origin and destination
	def is_obstructed?(destination_x, destination_y)

		# check if there is a piece on the destination square
		other_piece = game.pieces.where(x_coordinate: destination_x, y_coordinate: destination_y ).first
		if other_piece.present? 
			return true
		end
		
		# make the default return false 
		found = false  

		# Psuedocode
		# create integer range from origin.upto.destination e.g. 2...5 => [2,3,4,5]
		# query database through entire range

		# horizontal movement: left => right
		(self.x_coordinate + 1).upto(destination_x - 1).each do |x|
			between_squares = game.pieces.where(x_coordinate: x, y_coordinate: destination_y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# horizontal movement: right => left 
		(self.x_coordinate - 1).downto(destination_x).each do |x|
		between_squares = game.pieces.where(x_coordinate: x, y_coordinate: destination_y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# vertical movement: bottom => top 
		(self.y_coordinate + 1).upto(destination_y).each do |y|
			between_squares = game.pieces.where(x_coordinate: destination_x, y_coordinate: y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

	end
end