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
	 			game_id: id)
	 	end

	 	#black pieces
	 	Rook.create(x_coordinate: 1, y_coordinate: 8, color: 'black', game_id: id)
	 	Knight.create(x_coordinate: 2, y_coordinate: 8, color: 'black', game_id: id)
	 	Bishop.create(x_coordinate: 3, y_coordinate: 8, color: 'black', game_id: id)
	 	Queen.create(x_coordinate: 4, y_coordinate: 8, color: 'black', game_id: id)
	 	King.create(x_coordinate: 5, y_coordinate: 8, color: 'black', game_id: id)
	 	Bishop.create(x_coordinate: 6, y_coordinate: 8, color: 'black', game_id: id)
	 	Knight.create(x_coordinate: 7, y_coordinate: 8, color: 'black', game_id: id)
	 	Rook.create(x_coordinate: 8, y_coordinate: 8, color: 'black', game_id: id)

	 	#white pawns
	 	(0..7).each do |n|
	 		Pawn.create(
	 			x_coordinate: n,
	 			y_coordinate: 2,
	 			color: 'white',
	 	 		game_id: id)
	 			
	 	end

	 	#white pieces
	 	Rook.create(x_coordinate: 1, y_coordinate: 1, color: 'white', game_id: id)
	 	Knight.create(x_coordinate: 2, y_coordinate: 1, color: 'white', game_id: id)
	 	Bishop.create(x_coordinate: 3, y_coordinate: 1, color: 'white', game_id: id)
	 	Queen.create(x_coordinate: 4, y_coordinate: 1, color: 'white', game_id: id)
	 	King.create(x_coordinate: 5, y_coordinate: 1, color: 'white', game_id: id)
	 	Bishop.create(x_coordinate: 6, y_coordinate: 1, color: 'white', game_id: id)
	 	Knight.create(x_coordinate: 7, y_coordinate: 1, color: 'white', game_id: id)
	 	Rook.create(x_coordinate: 8, y_coordinate: 1, color: 'white', game_id: id)

	 end

	 def set_white_player(user)
	 	update_attributes(:white_player_id => user, :turn => user) if white_player_id.nil?
	 end

	 def set_black_player(user)
		update_attribute(:black_player_id, user) if black_player_id.nil?
	 end

end
