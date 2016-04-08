require 'rails_helper'


RSpec.describe Game, type: :model do
	describe "setting up new board" do
		it "should set up new board with all the chess pieces" do 
			@game = Game.create
			expect(@game.pieces.count).to eq 32
		end

		
		it "should return true if queen or rook can capture the king" do
			@game = Game.create
			@game.pieces.each(&:delete)
			@white_queen = Queen.create(
		      x_coordinate: 5,
		      y_coordinate: 4,
		      game: @game,
		      color: "white"
		    )
		    @white_rook = Rook.create(
		      x_coordinate: 1,
		      y_coordinate: 8,
		      game: @game,
		      color: "white"
		    )
		    @black_king = King.create(
		      x_coordinate: 6,
		      y_coordinate: 8,
		      game: @game,
		      color: "black"
		    )
		    expect(@game.is_check?).to eq true
		end
	end	
end

