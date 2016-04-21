class Bishop < Piece

	def valid_move?(x, y)
		return false if obstructed_diagonally?(x,y)
		return false if off_board?(x,y)
		return false if no_move?(x,y)

		diagonal_move?(x,y) ? true : false
	end

end
