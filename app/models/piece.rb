class Piece < ActiveRecord::Base
	belongs_to :game
	
	# lookup helper method
	def destination_square_piece(destination_x, destination_y)
		game.pieces.where(x_coordinate: destination_x, y_coordinate: destination_y).take
	end

	def capture(target_piece, target_x, target_y)
    update(x_coordinate: target_x, y_coordinate: target_y)
    target_piece.update(taken: true, x_coordinate: nil, y_coordinate: nil)
  end

	def move_to!(destination_x, destination_y)
		destination_piece = destination_square_piece(destination_x, destination_y)
		
		# if origin an destination are the same color, don't allow move
		if destination_piece.present? && color == destination_piece.color
			return false

		# return true and update coordinates if no piece on destination sqaure
		elsif destination_piece.present? == false
			update(x_coordinate: destination_x, y_coordinate: destination_y)
			return true

		# if destination square has opposite color piece, return true and update coordinates
		elsif destination_piece.present? && color != destination_piece.color
			update(x_coordinate: destination_x, y_coordinate: destination_y)
    	destination_piece.update(taken: true, x_coordinate: nil, y_coordinate: nil)
	  	return true
	  end
	end
  
	def is_obstructed?(destination_x, destination_y)
		# accepts destination coordinates & returns a boolean
		# 'true' means there is a piece b/t the origin and destination
		
		# create integer range from origin to destination
		# query database and check for pieces

		destination_piece = destination_square_piece(destination_x, destination_y)

		# check for piece on destination square
		if destination_piece.present? 
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