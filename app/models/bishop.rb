class Bishop < Piece

	def valid_move?(x, y)
		# return false if is_obstructed?(x, y) # this method breaks the function for some reason
		return false if !on_board?(x,y) # fixed helper method
		(x - x_coordinate).abs == (y - y_coordinate).abs
	end

end
