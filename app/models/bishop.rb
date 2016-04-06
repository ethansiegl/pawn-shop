class Bishop < Piece

	def valid_move?(x, y)
		return false if is_obstructed?(x,y)
		return false if !on_board?(x,y) 
		(x - x_coordinate).abs == (y - y_coordinate).abs
	end

end
