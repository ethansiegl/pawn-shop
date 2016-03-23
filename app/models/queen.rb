class Queen < Piece

	def valid_move?(move_x, move_y)
		if ## horizontal / vertical /diagonal
			return true
		else
			return false
		end
	end

end
