class Rook < Piece
	
	def valid_move?(x, y)
		return false if is_obstructed?(x, y)

		if x_coordinate != x && y_coordinate != y
			return false
		end
		true
	end

end