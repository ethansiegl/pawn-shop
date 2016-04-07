class Bishop < Piece

	def valid_move?(x, y)
		return false if is_obstructed?(x,y)
		return false if !on_board?(x,y) 
		return false if no_move?(x,y)

		diagonal_move?(x,y) ? true : false
	end

end
