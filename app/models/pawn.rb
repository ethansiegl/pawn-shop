class Pawn < Piece

	def valid_move?(x,y)
		return false if obstructed_vertically?(x,y)
		return false if off_board?(x,y)
		return false if backward_move?(x,y)
		return false if horizontal_move?(x,y)
		return false if diagonal_move?(x,y)
		return true if capture_possible?(x,y)

		if first_move?
			return false if (y-y_coordinate).abs > 2 || (y-y_coordinate).abs < 1
		else
			return false if (y-y_coordinate).abs > 1
		end
		true
	end

	def capture_possible?(x,y)
		x_diff = (x-x_coordinate).abs
		y_diff = (y-y_coordinate).abs
		return false if piece_at(x,y).nil?
		return false if piece_at(x,y).color == self.color
		return true if x_diff == 1 && y_diff == 1
	end

	def first_move?
		return true if color == 'white' && position_y == 2
    return true if color == 'black' && position_y == 7
    false
	end

	def backward_move?(x,y)
		if (is_white?(self) && (y<y_coordinate)) || (!is_white?(self) && (y>y_coordinate))
			return true
		else
			return false
		end
	end
end
