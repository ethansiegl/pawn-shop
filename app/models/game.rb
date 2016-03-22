class Game < ActiveRecord::Base
	after_create :initiate_new_board

	has_many :pieces
	belongs_to :user


	 def initiate_new_board
	 	#black pawns
	 	(1..8).each do |n|
	 		Pawn.create(
	 			x_coordinate: n,
	 			y_coordinate: 6,
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
	 	(0..7).each do |n|
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
end
