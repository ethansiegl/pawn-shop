class King < Piece

	def valid_move?(x,y)
		return false if is_obstructed?(x,y)
		return false if !on_board?(x,y)
		return false if no_move?(x,y)
		return false if puts_in_check?(x,y)

		if (x - x_coordinate).abs <= 1 && (y - y_coordinate).abs <= 1 && ((x != x_coordinate) || (y != y_coordinate))
			return true
		else
			return false
		end
	end

	def can_move_out_of_check?
		starting_x_pos = x_coordinate
		starting_y_pos = y_coordinate
		keep_playing = false
		(x_coordinate - 1)..(x_coordinate + 1).each do |x|
			(y_coordinate - 1)..(y_coordinate + 1).each do |y|
				update!(x_coordinate: x, y_coordinate: y) if valid_move?(x, y)
				keep_playing = true unless game.in_check?(color)
				update!(x_coordinate: starting_x_pos, y_coordinate: starting_y_pos)
			end
		end
		keep_playing
	end

end
