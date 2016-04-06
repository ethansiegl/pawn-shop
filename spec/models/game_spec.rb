require 'rails_helper'


RSpec.describe Game, type: :model do
	describe "setting up new board" do
		it "should set up new board with all the chess pieces" do 
			g = Game.create
			expect(g.pieces.count).to eq 32
		end
	end

	describe "checking the status of game if in check" do

		it "should return true if the game is in check" do
			@game = Game.new
			@white_king = King.create(
				x_coordinate: 2,
				y_coordinate: 2,
				game: @game,
				color: "white",
				turn: white_player_id)

			@black_rook = Rook.create(
				x_coordinate: 2,
				y_coordinate: 4,
				game: @game,
				color: "white",
				turn: white_player_id)
			expect(@black_rook.valid_move?(2, 2)).to eq true

		end
	end
end

