require "rails_helper"

RSpec.describe Piece, :type => :model do
	before :each do 
		@game = Game.create
		@white_rook = Rook.create(
			x_coordinate: 1,
			y_coordinate: 1,
			game: @game, 
			color: "white"
		)
	end

  describe "tests 'is_obstructed' method," do
    it "should return 'FALSE' if there is NO OBSTRUCTION" do 	
      expect(@white_rook.is_obstructed?(4,4)).to eq false
      # checking A6 C4 => false
    end

    it "should return 'true' if there is a piece on the destination coordinate" do 
    	black_rook = Rook.create(
				x_coordinate: 6,
				y_coordinate: 4,
				game: @game, 
				color: "black"
			)
    	expect(@white_rook.is_obstructed?(6,4)).to eq true
    end

    it "should return 'FALSE' if there is a piece on the destination coordinate in another game" do 
    	other_game = Game.create
    	black_rook = Rook.create(
				x_coordinate: 6,
				y_coordinate: 4,
				game: other_game, 
				color: "black"
			)
    	expect(@white_rook.is_obstructed?(6,4)).to eq false
    end

    it "should return 'true' if there is a piece on the way to the destination coordinate in the SAME ROW: left => right" do 
    	black_rook = Rook.create(
				x_coordinate: 4,
				y_coordinate: 1,
				game: @game, 
				color: "black"
			)
    	expect(@white_rook.is_obstructed?(5,1)).to eq true
    end

    it "should return 'true' if there is a piece on the way to the destination coordinate in the SAME ROW: right => left" do 
    	black_rook = Rook.create(
				x_coordinate: 7,
				y_coordinate: 1,
				game: @game, 
				color: "black"
			)
    	black_knight = Knight.create(
    		x_coordinate: 6,
    		y_coordinate: 1,
    		game: @game,
    		color: "black"
  		)
    	expect(black_rook.is_obstructed?(4,1)).to eq true
    end

    it "should return 'false' if there is a piece on the way to the destination coordinate in another row" do 
    	black_rook = Rook.create(
				x_coordinate: 4,
				y_coordinate: 2,
				game: @game, 
				color: "black"
			)
    	expect(@white_rook.is_obstructed?(5,1)).to eq false
    end

    it "should return 'TRUE' if there is a piece on the way to the destination coordinate in the SAME COLUMN" do 
    	black_rook = Rook.create(
				x_coordinate: 1,
				y_coordinate: 5,
				game: @game, 
				color: "black"
			)
    	expect(@white_rook.is_obstructed?(1,7)).to eq true
    end
  end
end
