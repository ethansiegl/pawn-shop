class King < Piece

	def valid_move?(x,y)
		return false if is_obstructed?(x,y)
		return false if !on_board?(x,y)
		return false if no_move?(x,y)

		if (x - x_coordinate).abs <= 1 && (y - y_coordinate).abs <= 1 && ((x != x_coordinate) || (y != y_coordinate))
			return true
		else
			return false
		end
	end
end
