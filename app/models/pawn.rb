class Pawn < Piece
	
	def valid_move?(x,y)
		# return false if is_obstructed?(x,y)
		return false if !on_board?(x,y)
		return false if backward_move?(x,y)
		return false if horizontal_move?(x,y)
		if first_move? 
			return false if (y-y_coordinate).abs > 2 || (y-y_coordinate).abs < 1
		else
			return false if (y-y_coordinate).abs > 1
		end

		true
	end

	def first_move?
		if (y_coordinate == 2 && is_white?(self)) || (y_coordinate == 7 && !is_white?(self))
			return true
		else
			return false
		end
	end

	def backward_move?(x,y)
		if (is_white?(self) && (y<y_coordinate)) || (!is_white?(self) && (y>y_coordinate))
			return true
		else
			return false
		end
	end



end
