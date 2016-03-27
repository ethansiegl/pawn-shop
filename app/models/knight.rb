class Knight < Piece

	def valid_move?(move_x, move_y)
		if ((x_move - x_coordinate).abs == 2 && (y_move - y_coordinate).abs == 1) ||
				((x_move - x_coordinate).abs == 1 && (y_move - y_coordinate) == 2 )
				&& ((move_x != x_coordinate) && (move_y != y_coordinate))
			return true
		else
			return false
		end
	end

end
