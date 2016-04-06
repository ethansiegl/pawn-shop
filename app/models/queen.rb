class Queen < Piece

	def valid_move?(x,y)
		return false if is_obstructed?(x,y)
		
		return false if !on_board?(x,y)
		return false if no_move?(x,y)

		if diagonal_move?(x,y) || vertical_move?(x,y) || horizontal_move?(x,y)
			return true
		else
			return false
		end
	end
	
end
