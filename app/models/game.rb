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

	def in_check?(color)
		king = pieces.find_by(type: 'King', color: color)

		if color == "white"
			opposite_color = "black"
		elsif color == "black"
			opposite_color = "white"
		end

		opponenets = game.pieces.where(color: opposite_color)
		
		opponenets.each do |piece|
			if piece.valid_move?(king.x_coordinate, king.y_coordinate)
				return true
			end
		end
		false
	end

	def checkmate?
		true
		# should return false if king is not in check
		# should check to see if another piece can capture checking piece
		# should check if king can move out of check
		# should check if another piece can block check 
	end

	def find_king(color)
		game.pieces.find_by(type: 'King', color: color.to_s)
	end

	def set_white_player(user)
	 	update_attributes(:white_player_id => user, :turn => user) if white_player_id.nil?
	end

	def set_black_player(user)
		update_attribute(:black_player_id, user) if black_player_id.nil?
	end
end

