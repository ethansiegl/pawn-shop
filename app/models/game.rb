class Game < ActiveRecord::Base
	has_many :pieces

	 def initiate_new_board
	 	#black pawns
	 	(0..7).each do |n|
	 		Pawn.create(
	 			x_coordinate: n,
	 			y_coordinate: 6,
	 			color: 'black')
	 	end

	 	#black pieces
	 	Rook.create(x_coordinate: 0, y_coordinate: 6, color: 'black')
	 	Knight.create(x_coordinate: 1, y_coordinate: 6, color: 'black')
	 	Bishop.create(x_coordinate:2, y_coordinate: 6, color: 'black')
	 	Queen.create(x_coordinate:3, y_coordinate: 6, color: 'black')
	 	King.create(x_coordinate:4, y_coordinate: 6, color: 'black')
	 	Bishop.create(x_coordinate:5, y_coordinate: 6, color: 'black')
	 	Knight.create(x_coordinate: 6, y_coordinate: 6, color: 'black')
	 	Rook.create(x_coordinate: 7, y_coordinate: 6, color: 'black')

	 	#white pawns
	 	(0..7).each do |n|
	 		Pawn.create(
	 			x_coordinate: n,
	 			y_coordinate: 0,
	 			color: 'white')
	 	end

	 	#white pieces
	 	Rook.create(x_coordinate: 0, y_coordinate: 0, color: 'white')
	 	Knight.create(x_coordinate: 1, y_coordinate: 0, color: 'white')
	 	Bishop.create(x_coordinate:2, y_coordinate: 0, color: 'white')
	 	Queen.create(x_coordinate:3, y_coordinate: 0, color: 'white')
	 	King.create(x_coordinate:4, y_coordinate: 0, color: 'white')
	 	Bishop.create(x_coordinate:5, y_coordinate: 0, color: 'white')
	 	Knight.create(x_coordinate: 6, y_coordinate: 0, color: 'white')
	 	Rook.create(x_coordinate: 7, y_coordinate: 0, color: 'white')

	 end
end
