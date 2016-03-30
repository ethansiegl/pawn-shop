class Piece < ActiveRecord::Base
	belongs_to :game

	def move_to!(destination_x, destination_y)
		destination_piece = piece_at(destination_x, destination_y)

		# do not allow move if origin and destination piece are the same color
		return false if friendly_piece?(destination_piece)

		# move origin piece if destination square is empty
		if !destination_piece.present?
			update_coordinates(destination_x, destination_y)

		# capture destination piece if opposite color
		else
			capture!(destination_piece)
			update_coordinates(destination_x, destination_y)
		end
	end


 	# helper methods
	def is_obstructed?(destination_x, destination_y)
		# returns boolean
		# does NOT work for knight movement

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

	def on_board?(x, y)
 		return false if x > 8 || y > 8 || x < 1 || y < 1
		else true
  end

	def no_move?(x, y)
		(x == x_coordinate) && (y == y_coordinate)
	end

	# helper methods
	def piece_at(x, y)
		game.pieces.where(x_coordinate: x, y_coordinate: y).take
	end

  def update_coordinates(new_x, new_y)
  	update(x_coordinate: new_x, y_coordinate: new_y)
  end

	def horizontal_move?(x, y)
		return true if (x == x_coordinate) && (y != y_coordinate)
	end

	def vertical_move?(x, y)
		return true if (x != x_coordinate) && (y == y_coordinate)
	end

	def diagonal_move?(x, y)
		return true if (x - x_coordinate).abs == (y - y_coordinate).abs
	end

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

 	def is_white?(piece)
 		return false if piece.color == "black"
 	else
 		return true
 	end

end
