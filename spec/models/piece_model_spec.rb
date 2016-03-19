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

	describe "tests 'move_to!' method," do
		it "should return 'true' if there is no piece on the destination square" do
			expect(@white_rook.move_to!(2,1)).to eq true
		end

		it "should return 'false' if there is a piece of the same color on the destination square" do 
			@white_pawn = Pawn.create(
				x_coordinate: 2,
				y_coordinate: 2,
				game: @game,
				color: "white"
				)
			expect(@white_rook.move_to!(2,2)).to eq false
		end

		it "should return 'true' if there is a piece of the opposite color on the destination square" do 
			@white_pawn = Pawn.create(
				x_coordinate: 2,
				y_coordinate: 2,
				game: @game,
				color: "black"
				)
			expect(@white_rook.move_to!(2,2)).to eq true
		end

		# it "should update captured piece status (taken) to 'true'" do 
		# 	@black_pawn = Pawn.create(
		# 		x_coordinate: 2,
		# 		y_coordinate: 2,
		# 		game: @game,
		# 		color: "black"
		# 		)
		# 	@white_rook.move_to!(2,2)
		# 	expect(@black_pawn).to have_attributes(taken: true)
		# end

		it "should update piece coordinates after capturing opposite color piece" do 
			@black_pawn = Pawn.create(
				x_coordinate: 2,
				y_coordinate: 2,
				game: @game,
				color: "black"
				)
			@white_rook.move_to!(2,2)
			expect(@white_rook.x_coordinate).to eq 2 
			expect(@white_rook.y_coordinate).to eq 2
		end
	end

  describe "tests 'is_obstructed' method," do
    it "should return 'FALSE' if there is NO OBSTRUCTION" do 	
      expect(@white_rook.is_obstructed?(4,4)).to eq false
    end

    it "should return 'true' if there is a piece ON the destination coordinate" do 
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

    it "should return 'TRUE' if there is a piece ON THE WAY to the destination coordinate in the SAME ROW moving LEFT => RIGHT" do 
    	black_rook = Rook.create(
				x_coordinate: 4,
				y_coordinate: 1,
				game: @game, 
				color: "black"
			)
    	expect(@white_rook.is_obstructed?(5,1)).to eq true
    end

    it "should return 'TRUE' if there is a piece ON THE WAY to the destination coordinate in the SAME ROW moving RIGHT => LEFT" do 
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

    it "should return 'FALSE' if there is a piece ON THE WAY to the destination coordinate in another row" do 
    	black_rook = Rook.create(
				x_coordinate: 4,
				y_coordinate: 2,
				game: @game, 
				color: "black"
			)
    	expect(@white_rook.is_obstructed?(5,1)).to eq false
    end

    it "should return 'TRUE' if there is a piece ON THE WAY to the destination coordinate in the SAME COLUMN moving BOTTOM => TOP" do 
    	black_rook = Rook.create(
				x_coordinate: 1,
				y_coordinate: 5,
				game: @game, 
				color: "black"
			)
    	expect(@white_rook.is_obstructed?(1,7)).to eq true
    end

    it "should return 'TRUE' if there is a piece ON THE WAY to the destination coordinate in the SAME COLUMN moving TOP => BOTTOM" do 
    	black_rook = Rook.create(
				x_coordinate: 1,
				y_coordinate: 7,
				game: @game, 
				color: "black"
			)
			white_knight = Knight.create(
				x_coordinate: 1,
				y_coordinate: 6,
				game: @game,
				color: "black"
			)
    	expect(black_rook.is_obstructed?(1,4)).to eq true
    end

    it "should return 'TRUE' if there is a piece ON THE WAY to the destination coordinate moving DIAGNOALLY RIGHT + UP" do
    	black_bishop = Bishop.create(
    		x_coordinate: 2,
				y_coordinate: 2,
				game: @game,
				color: "black"
  		)
  		white_knight = Knight.create(
  			x_coordinate: 3,
				y_coordinate: 3,
				game: @game,
				color: "white"	
			) 
    	expect(black_bishop.is_obstructed?(5,5)).to eq true
  	end

    it "should return 'TRUE' if there is a piece ON THE WAY to the destination coordinate moving DIAGNOALLY RIGHT + DOWN" do
    	black_bishop = Bishop.create(
    		x_coordinate: 1,
				y_coordinate: 7,
				game: @game,
				color: "black"
  		)
  		white_knight = Knight.create(
  			x_coordinate: 2,
				y_coordinate: 6,
				game: @game,
				color: "white"	
			) 
    	expect(black_bishop.is_obstructed?(3,5)).to eq true
  	end

  	it "should return 'TRUE' if there is a piece ON THE WAY to the destination coordinate moving DIAGNOALLY LEFT + UP" do
    	black_bishop = Bishop.create(
    		x_coordinate: 7,
				y_coordinate: 1,
				game: @game,
				color: "black"
  		)
  		white_knight = Knight.create(
  			x_coordinate: 6,
				y_coordinate: 2,
				game: @game,
				color: "white"	
			) 
    	expect(black_bishop.is_obstructed?(5,3)).to eq true
  	end

  	it "should return 'TRUE' if there is a piece ON THE WAY to the destination coordinate moving DIAGNOALLY LEFT + DOWN" do
    	black_bishop = Bishop.create(
    		x_coordinate: 6,
				y_coordinate: 6,
				game: @game,
				color: "black"
  		)
  		white_knight = Knight.create(
  			x_coordinate: 5,
				y_coordinate: 5,
				game: @game,
				color: "white"	
			) 
    	expect(black_bishop.is_obstructed?(4,4)).to eq true
  	end
  end
end
