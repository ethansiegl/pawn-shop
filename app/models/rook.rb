class Rook < Piece

	def valid_move?(x, y)
		return false if obstructed_vertically?(x, y)
		return false if obstructed_horizontally?(x,y)
		return false if off_board?(x,y)
 		return false if no_move?(x,y)

 		if vertical_move?(x,y) || horizontal_move?(x,y)
 			return true
 		else
 			return false
 		end
	end

end
