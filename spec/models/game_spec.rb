require 'rails_helper'

RSpec.describe Game, type: :model do
	describe "setting up new board" do
		it "should set up new board with all the chess pieces" do
			@game = Game.create
			expect(@game.pieces.count).to eq 32
		end

		it "should return true if game is in check" do
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
		    expect(@game.check?("black")).to eq true
		end
	end

	describe "test checkmate method" do
		it "should return true if the game is in checkmate" do
			@game = Game.create
	    @game.pieces.each(&:delete)
	    @white_king = King.create(
	      x_coordinate: 1,
	      y_coordinate: 1,
	      game: @game,
	      color: "white"
	    )
	    @black_rook = Rook.create(
	    	x_coordinate: 7,
	      y_coordinate: 1,
	      game: @game,
	      color: "black"
	    	)
	    @black_rook = Rook.create(
	    	x_coordinate: 7,
	      y_coordinate: 2,
	      game: @game,
	      color: "black"
	    	)
			expect(@game.checkmate?("white")).to eq true
		end

		it "should return false if the king is not in check" do
			@game = Game.create
	    @game.pieces.each(&:delete)
	    @white_king = King.create(
	      x_coordinate: 1,
	      y_coordinate: 1,
	      game: @game,
	      color: "white"
	    )
			expect(@game.checkmate?("white")).to eq false
		end

		it "should return false if piece causing check can be captured by friendly piece" do
			@game = Game.create
	    @game.pieces.each(&:delete)
	    @white_king = King.create(
      	x_coordinate: 1,
      	y_coordinate: 1,
      	game: @game,
      	color: "white"
	    )
      @black_rook = Rook.create(
    		x_coordinate: 7,
      	y_coordinate: 1,
      	game: @game,
      	color: "black"
    	)
    	@white_rook = Rook.create(
    		x_coordinate: 7,
      	y_coordinate: 7,
      	game: @game,
      	color: "white"
  		)
			expect(@game.checkmate?("white")).to eq false
		end

		it "should return false if King can move out of check" do
			@game = Game.create
	    @game.pieces.each(&:delete)
	    @white_king = King.create(
      	x_coordinate: 1,
      	y_coordinate: 1,
      	game: @game,
      	color: "white"
	    )
      @black_rook = Rook.create(
    		x_coordinate: 7,
      	y_coordinate: 1,
      	game: @game,
      	color: "black"
    	)
			expect(@game.checkmate?("white")).to eq false
		end
	end
	describe "test stalemate method" do
		it "should return true if the game is in stalemate" do
			@game = Game.create
	    @game.pieces.each(&:delete)
	    @white_king = King.create(
	      x_coordinate: 1,
	      y_coordinate: 1,
	      game: @game,
	      color: "white"
	    )
	    @black_rook = Rook.create(
	    	x_coordinate: 7,
	      y_coordinate: 2,
	      game: @game,
	      color: "black"
	    	)
	    @black_rook = Rook.create(
	    	x_coordinate: 2,
	      y_coordinate: 7,
	      game: @game,
	      color: "black"
	    	)
			expect(@game.stalemate?("white")).to eq true
		end
	end
end
