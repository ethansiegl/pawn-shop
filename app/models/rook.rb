class Rook < Piece
	
	def valid_move?(destination_x, destination_y)
		# return false if !move_to?(destination_x, destination_y)

		
		return false if self.is_obstructed?(destination_x, destination_y)
		
		destination_square = game.pieces.where(x_coordinate: destination_x, y_coordinate: destination_y).take

		if x_coordinate != destination_x && y_coordinate != destination_y
			return false
		end

		

		true
	end
end

# query origin square location (x,y)

# find destination square location (x,y)

# determine whether destination has same x or y

# return true or false depending on x and y values 