class Pawn < Piece
	
	def valid_move?(x,y)
		return false if is_obstructed?(x,y)
		return false if !on_board?(x,y)
		return false if backward_move(x,y)
		if !taking_opponent?
			return false if x != x_coordinate
		end

		if first_move? 
			return false if (y-y_coordinate).abs > 2
			else
			return false if (y-y_coordinate).abs > 1 
		end
	end

	def first_move?
		return false unless (y_coordinate == 2 && is_white?) || (y_coordinate == 7 && !is_white?)
	end
	
	def taking_opponent?(x,y)
		return false if piece_at(x,y) == friendly_piece?
	end

	def backward_move?(x,y)
		return true if (is_white? && y<y_coordinate) && (!is_white? && y>y_coordinate)
		else return false
	end



end
