class Piece < ActiveRecord::Base
	belongs_to :game
	
	def destination_square_piece
		destination_square_piece = game.pieces.where(x_coordinate: destination_x, y_coordinate: destination_y).take
	end

	def move_to!(destination_x, destination_y)
		# allows pieces to move and capture
		# returns false if piece attempts to move onto a square occupied by a piece of the same color
		
		# if there is no piece on the destination square, allow move
		return true if destination_square_piece.present? == false

		# if origin and destination pieces are the same color, do not allow move
		return false if color == destination_square_piece.color 

		# else if color == destination.color
		capture(destination_square_piece, destination_x, destination_y)
		true
	end

  def capture(target_piece, target_x, target_y)
    update(x_coordinate: target_x, y_coordinate: target_y)
    
    target_piece.update(taken: true, x_coordinate: nil, y_coordinate: nil)
  end

	def is_obstructed?(destination_x, destination_y)
		# accepts destination coordinates & returns a boolean
		# 'true' means there is a piece b/t the origin and destination
		
		# create integer range from origin to destination
		# query database and check for pieces

		# check for piece on destination square
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