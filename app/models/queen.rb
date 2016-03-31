class Queen < Piece

<<<<<<< HEAD
	def valid_move?(x,y)
		return false if !on_board?(x,y)
		return false if no_move?(x,y)

		if diagonal_move?(x,y) || vertical_move?(x,y) || horizontal_move?(x,y)
			return true
		else
			return false
		end
	end
=======
	#def valid_move?(move_x, move_y)
		#if horizontal
			#vertical
			#diagonal_left
			#diagonal_right
			##&& ((move_x != x_coordinate) && (move_y != y_coordinate))
			#return true
		#else
			#return false
		#end
	#end

>>>>>>> 168dfc9aa484faaeb11b56235fe3a9fd13f4d906
end
