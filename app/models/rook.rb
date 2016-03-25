class Rook < Piece
	
	def valid_move?(destination_x, destination_y)
		return false if is_obstructed?(destination_x, destination_y)

		if x_coordinate != destination_x && y_coordinate != destination_y
			return false
		end
		true
	end
	
end