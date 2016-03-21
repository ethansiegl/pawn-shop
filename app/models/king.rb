class King < Piece

	def valid_move?(move_x, move_y)

		if abs(move_x - x_coordinate) <= 1 && abs(move_y - y_coordinate) <= 1 && (move_x =! x_coordinate || move_y =! y_coordinate)
			return true
		else
				return false
		end
	end

end
