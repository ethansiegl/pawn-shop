class Queen < Piece

	def valid_move?(move_x, move_y)
		if #horizontal
			#vertical
			#diagonal_left
			#diagonal_right
			&& ((move_x != x_coordinate) && (move_y != y_coordinate))
			return true
		else
			return false
		end
	end

end
