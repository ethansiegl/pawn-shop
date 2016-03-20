class King < Piece

	def valid_move?(x_coor, y_coor)
		start_pos_x = start_x
		start_pos_y = start_y
		if w == x + 1 || w == x - 1 || z == y + 1 || z == y - 1
			return true
		else
				return false
		end
	end

end
