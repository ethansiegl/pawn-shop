class Piece < ActiveRecord::Base
	belongs_to :game
	
	# piece accepts destination coordinates
	def move_to!(destination_x, destination_y)
		# check for white piece on destination square 
		white_destination_square_piece = game.pieces.where(x_coordinate: destination_x, y_coordinate: destination_y, color: "white").first

		# check for black piece on destination square 
		black_destination_square_piece = game.pieces.where(x_coordinate: destination_x, y_coordinate: destination_y, color: "black").first
		
		# if origin and destination pieces are white, do not allow move
		if white_destination_square_piece.present? && self.color == white_destination_square_piece.color
			return false
		end

		# if origin and destination pieces are black, do not allow move
		if black_destination_square_piece.present? && self.color == black_destination_square_piece.color
			return false
		end

		# if origin is white and destination is black, return true
		true
	end

	# method accepts destination coordinates & returns a boolean
	# returning 'true' means there is a piece b/t the origin and destination
		# ex: white_pawn.is_obstructed?(1,2) => false
	def is_obstructed?(destination_x, destination_y)
		# create integer range from origin to destination
		# create database queries based on integer range and destination coordinates
		# check for pieces

		# check for piece on destination square
		destination_square_piece = game.pieces.where(x_coordinate: destination_x, y_coordinate: destination_y ).first
		if destination_square_piece.present? 
			return true
		end
		
		# default return false 
		found = false  

		# moving horizontally left => right
		(self.x_coordinate + 1).upto(destination_x).each do |x|
			between_squares = game.pieces.where(x_coordinate: x, y_coordinate: destination_y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# moving horizontally right => left 
		(self.x_coordinate - 1).downto(destination_x).each do |x|
		between_squares = game.pieces.where(x_coordinate: x, y_coordinate: destination_y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# moving vertically bottom => top 
		(self.y_coordinate + 1).upto(destination_y).each do |y|
			between_squares = game.pieces.where(x_coordinate: destination_x, y_coordinate: y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# moving vertically top => bottom
		(self.y_coordinate - 1).downto(destination_y).each do |y|
			between_squares = game.pieces.where(x_coordinate: destination_x, y_coordinate: y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# moving diagonally right + up
		(self.y_coordinate + 1).upto(destination_y).each do |y|
			between_squares = game.pieces.where(x_coordinate: self.x_coordinate + 1, y_coordinate: y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# moving diagonally right + down
		(self.y_coordinate - 1).downto(destination_y).each do |y|
			between_squares = game.pieces.where(x_coordinate: self.x_coordinate + 1, y_coordinate: y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# moving diagonally left + up
		(self.y_coordinate + 1).upto(destination_y).each do |y|
			between_squares = game.pieces.where(x_coordinate: self.x_coordinate - 1, y_coordinate: y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# moving diagonally left + down
		(self.y_coordinate - 1).downto(destination_y).each do |y|
			between_squares = game.pieces.where(x_coordinate: self.x_coordinate - 1, y_coordinate: y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found
	end
end