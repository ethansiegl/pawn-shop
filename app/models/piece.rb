class Piece < ActiveRecord::Base
	belongs_to :game
	
	def move_to!(destination_x, destination_y)
		destination_piece = piece_at(destination_x, destination_y)
		
		# do not allow move if origin and destination piece are the same color
		return false if friendly_piece?(destination_piece)

		# move origin piece if destination square is empty
		if !destination_piece.present?
			update_coordinates(destination_x, destination_y)
		else 
			capture!(destination_piece)
			update_coordinates(destination_x, destination_y)
		end
	end
  
	def is_obstructed?(destination_x, destination_y)
		# accepts destination coordinates & returns a boolean
		# 'true' means there is a piece b/t the origin and destination
		
		# create integer range from origin to destination
		# query database and check for pieces

		destination_piece = piece_at(destination_x, destination_y)

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

	# helper methods 
	def piece_at(x, y)
		game.pieces.where(x_coordinate: x, y_coordinate: y).take
	end

	def capture!(target_piece)
    target_piece.update(taken: true, x_coordinate: nil, y_coordinate: nil)
  end

  def friendly_piece?(piece)
  	piece.present? && color == piece.color
  end

  def update_coordinates(new_x, new_y)
  	update(x_coordinate: new_x, y_coordinate: new_y)
  end
end