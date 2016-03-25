class King < Piece

	def valid_move?(move_x, move_y)
		if (move_x - x_coordinate).abs <= 1 && (move_y - y_coordinate).abs <= 1 && ((move_x != x_coordinate) || (move_y != y_coordinate))
			return true
		else
			return false
		end

	end

end
