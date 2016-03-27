class Queen < Piece

	def valid_move?(x,y)
		return false if is_obstructed?(x,y)
		return false if !on_board(x,y)
		return false if no_move?(x,y)

		return true if (x - x_coordinate) == (y - y_coordinate)
	end

end
