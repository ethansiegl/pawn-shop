class Piece < ActiveRecord::Base
	belongs_to :game
	
	# method accepts destination coordinates & returns a boolean
	# returning 'true' means there is a piece b/t the origin and destination
	def is_obstructed?(destination_x, destination_y)
		# create integer range from origin.to.destination
		# query database through entire range

		# check for piece on destination square
		destination_square_piece = game.pieces.where(x_coordinate: destination_x, y_coordinate: destination_y ).first
		if destination_square_piece.present? 
			return true
		end
		
		# default return false 
		found = false  

		# horizontal movement: left => right
		(self.x_coordinate + 1).upto(destination_x).each do |x|
			between_squares = game.pieces.where(x_coordinate: x, y_coordinate: destination_y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# horizontal movement: right => left 
		(self.x_coordinate - 1).downto(destination_x).each do |x|
		between_squares = game.pieces.where(x_coordinate: x, y_coordinate: destination_y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# vertical movement: bottom => top 
		(self.y_coordinate + 1).upto(destination_y).each do |y|
			between_squares = game.pieces.where(x_coordinate: destination_x, y_coordinate: y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# vertical movement: top => bottom
		(self.y_coordinate - 1).downto(destination_y).each do |y|
			between_squares = game.pieces.where(x_coordinate: destination_x, y_coordinate: y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# diagonal movement: right + up
		(self.y_coordinate + 1).upto(destination_y).each do |y|
			between_squares = game.pieces.where(x_coordinate: self.x_coordinate + 1, y_coordinate: y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# diagonal movement: right + down
		(self.y_coordinate - 1).downto(destination_y).each do |y|
			between_squares = game.pieces.where(x_coordinate: self.x_coordinate + 1, y_coordinate: y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# diagonal movement: left + up
		(self.y_coordinate + 1).upto(destination_y).each do |y|
			between_squares = game.pieces.where(x_coordinate: self.x_coordinate - 1, y_coordinate: y).first
			if between_squares.present? 
				found = true
				break 
			end
		end
		found

		# diagonal movement: left + down
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