require 'byebug'
class Game < ActiveRecord::Base

	after_create :initiate_new_board

	has_many :pieces
	belongs_to :user

  def initiate_new_board
	 	#black pawns
	 	(1..8).each do |n|
	 		Pawn.create(
	 			x_coordinate: n,
	 			y_coordinate: 7,
	 			color: 'black',
	 			game: self)
	 	end

	 	#black pieces
	 	Rook.create(x_coordinate: 1, y_coordinate: 8, color: 'black', game: self)
	 	Knight.create(x_coordinate: 2, y_coordinate: 8, color: 'black', game: self)
	 	Bishop.create(x_coordinate: 3, y_coordinate: 8, color: 'black', game: self)
	 	Queen.create(x_coordinate: 4, y_coordinate: 8, color: 'black', game: self)
	 	King.create(x_coordinate: 5, y_coordinate: 8, color: 'black', game: self)
	 	Bishop.create(x_coordinate: 6, y_coordinate: 8, color: 'black', game: self)
	 	Knight.create(x_coordinate: 7, y_coordinate: 8, color: 'black', game: self)
	 	Rook.create(x_coordinate: 8, y_coordinate: 8, color: 'black', game: self)

	 	#white pawns
	 	(1..8).each do |n|
	 		Pawn.create(
	 			x_coordinate: n,
	 			y_coordinate: 2,
	 			color: 'white',
	 			game: self)
 		end

	 	#white pieces
	 	Rook.create(x_coordinate: 1, y_coordinate: 1, color: 'white', game: self)
	 	Knight.create(x_coordinate: 2, y_coordinate: 1, color: 'white', game: self)
	 	Bishop.create(x_coordinate: 3, y_coordinate: 1, color: 'white', game: self)
	 	Queen.create(x_coordinate: 4, y_coordinate: 1, color: 'white', game: self)
	 	King.create(x_coordinate: 5, y_coordinate: 1, color: 'white', game: self)
	 	Bishop.create(x_coordinate: 6, y_coordinate: 1, color: 'white', game: self)
	 	Knight.create(x_coordinate: 7, y_coordinate: 1, color: 'white', game: self)
	 	Rook.create(x_coordinate: 8, y_coordinate: 1, color: 'white', game: self)
	end

	def checkmate?(color)
		checked_king = pieces.find_by(type: 'King', color: color)
		return false unless in_check?(color)
		return false if can_block_check?(color)
		return false if can_capture_checking_piece?(color)
		return false if checked_king.can_move_out_of_check?
		true
	end

	def in_check?(color)
		king = pieces.find_by(type: 'King', color: color)
		opponents = opponents_on_board(color)
		opponents.each do |piece|
			if piece.valid_move?(king.x_coordinate, king.y_coordinate)
				@piece_causing_check = piece
				return true
			end
		end
		false
	end

	def can_block_check?(color)
		king = find_king(color)
		friends = pieces.where(color: color).to_a
		enemies = opponents_on_board(color)
		@blockable_coordinates = []

		# horizontal cases
		if king.y_coordinate == @piece_causing_check.y_coordinate
			if king.x_coordinate < @piece_causing_check.x_coordinate
				(king.x_coordinate + 1).upto(@piece_causing_check.x_coordinate - 1).each do |x|
					@blockable_coordinates << [x, king.y_coordinate]
				end
			elsif king.x_coordinate > @piece_causing_check.x_coordinate
				(king.x_coordinate - 1).downto(@piece_causing_check + 1).each do |x|
					@blockable_coordinates << [x, king.y_coordinate]
				end
			end
		end

		# vertical cases
		if king.x_coordinate == @piece_causing_check.x_coordinate
			if king.y_coordinate < @piece_causing_check.y_coordinate
				(king.y_coordinate + 1).upto(@piece_causing_check.y_coordinate - 1).each do |y|
					@blockable_coordinates << [king.x_coordinate, y]
				end
			elsif king.y_coordinate > @piece_causing_check.y_coordinate
				(king.y_coordinate - 1).downto(@piece_causing_check + 1).each do |y|
					@blockable_coordinates << [king.x_coordinate, y]
				end
			end
		end

		#diagonal moves
		if king.x_coordinate < @piece_causing_check.x_coordinate
			if king.y_coordinate < @piece_causing_check.y_coordinate
				(king.x_coordinate + 1).upto(@piece_causing_check.x_coordinate - 1) do |x|
					(king.y_coordinate + 1).upto(@piece_causing_check.x_coordinate - 1) do |y|
						@blockable_coordinates << [x, y]
					end
				end
			elsif king.y_coordinate > @piece_causing_check.y_coordinate
				(king.x_coordinate + 1).upto(@piece_causing_check.x_coordinate - 1) do |x|
					(king.y_coordinate - 1).downto(@piece_causing_check.x_coordinate + 1) do |y|
						@blockable_coordinates << [x, y]
					end
				end
			end
		if king.x_coordinate > @piece_causing_check.x_coordinate
			if king.y_coordinate > @piece_causing_check.y_coordinate
				(king.x_coordinate - 1).downto(@piece_causing_check.x_coordinate + 1) do |x|
					(king.y_coordinate - 1).downto(@piece_causing_check.x_coordinate + 1) do |y|
						@blockable_coordinates << [x, y]
					end
				end
			elsif king.y_coordinate < @piece_causing_check.y_coordinate
				(king.x_coordinate - 1).downto(@piece_causing_check.x_coordinate + 1) do |x|
					(king.y_coordinate + 1).upto(@piece_causing_check.x_coordinate - 1) do |y|
						@blockable_coordinates << [x, y]
					end
				end
			end
		end
	 end
		return false unless @blockable_coordinates.any?
		friends.each do |piece|
			@blockable_coordinates.each do |position|
				return true if piece.valid_move?(position[0], position[1])
			end
		end
		false
	end

	def opponents_on_board(color)
		opposite_color = color == 'black' ? 'white' : 'black'
		pieces.where(x_coordinate: 1..8, y_coordinate: 1..8, color: opposite_color).to_a
	end

	def can_capture_checking_piece?(color)
		friendly_pieces = pieces_remaining(color)

		friendly_pieces.each do |piece|
			if piece.valid_move?(@piece_causing_check.x_coordinate, @piece_causing_check.y_coordinate)
				return true
			end
		end
		false
	end

	def find_king(color)
		pieces.where(type: 'King', color: color).first
	end

	def set_white_player(user)
	 	update_attributes(:white_player_id => user, :turn => user) if white_player_id.nil?
	end

	def set_black_player(user)
		update_attribute(:black_player_id, user) if black_player_id.nil?
	end

	def pieces_remaining(color)
    pieces.where(color: color).to_a
  end

	def is_check?
		if turn == white_player_id
			king = self.pieces.find_by(type: 'King', color: 'black')
			white_pieces = self.pieces.where(color: 'white')
			white_pieces.each do |piece|
				if piece.valid_move?(king.x_coordinate, king.y_coordinate)
					return true
				end
			end

		elsif turn == black_player_id
			king = self.pieces.find_by(type: 'King', color: 'white')
			black_pieces = self.pieces.where(color: 'black')
			black_pieces.each do |piece|
				if piece.valid_move?(king.x_coordinate, king.y_coordinate)
					return true
				end
			end
		else
			return false
		end
	end
end
