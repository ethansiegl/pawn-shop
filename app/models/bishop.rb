class Bishop < Piece

	def valid_move?(x, y)
		(x - x_coordinate).abs == (y - y_coordinate).abs
		# return false if is_obstructed?(x, y)
		#return false if !on_board?(x, y)



		
	end

end
