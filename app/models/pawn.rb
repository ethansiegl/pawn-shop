class Pawn < Piece
	
	def valid_move?(x,y)
		return false if is_obstructed?(x,y)
		return false if !on_board?(x,y)
		return false if backward_move?(x,y)
		return false if horizontal_move?(x,y)
		return true if capture_possible?(x,y)
		return false if diagonal_move?(x,y)  
		
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

	def can_be_promoted?(x,y)
		#white pawn can be promoted if 
		#they reach the other side
		if (y_coordinate == 8 && is_white?(self)) || (y_coordinate == 1 && !is_white?(self))
			return true
		else
			return false
		end
	end

	def pawn_promotion
		#this is where the changes to the pawn will be made. The pawn will be changed to 
		#Rook, Knight, Bishop, Queen.

		#This will work with first getting the information from the form. That way I will know which piece
		#the pawn is changing to
		x = params[:x].to_i 
		y = params[:y].to_i
		type = params[:type]
		color = params[:color]

		#Second I will change the attributes of the pawn piece since it will no longer exist
		update_attributes(
			x_coordinate: nil,
			y_coordinate: nil,
			 )

		#Third, I will create the new piece in its place. 
		game.pieces.create(
			x_coordinate: x,
			y_coordinate: y,
			type: type,
			color: color)
		
	end



end
