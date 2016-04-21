require "rails_helper"
RSpec.describe Piece, :type => :model do
	before :each do
		@game = Game.create
		@game.pieces.each(&:delete)
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

		it "should when capturing a piece, update origin piece coordinates and return true" do
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

  describe "tests 'obstructed_horizontally' method," do
    it "should return false if there is no obstruction" do
      expect(@white_rook.obstructed_horizontally?(4,4)).to eq false
    end

    it "should return true if there is a horizontal obstruction going left to right" do
    	black_rook = Rook.create(
				x_coordinate: 4,
				y_coordinate: 1,
				game: @game,
				color: "black"
			)
    	expect(@white_rook.obstructed_horizontally?(5,1)).to eq true
    end

    it "should return true if there is a horizontal obstruction moving right to left" do
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
    	expect(black_rook.obstructed_horizontally?(5,1)).to eq true
    end
	end

	describe "tests 'obstructed_vertically' method," do
		it "should return true if there is a vertical obstruction going up" do
			@black_pawn = Pawn.create(
				x_coordinate: 1,
				y_coordinate: 4,
				game: @game,
				color: "black"
			)
			expect(@white_rook.obstructed_vertically?(1,7)).to eq true
		end

		it "should return true if there is a vertical obstruction going down" do
			@black_rook = Rook.create(
				x_coordinate: 1,
				y_coordinate: 7,
				game: @game,
				color: "white"
			)
			@black_pawn = Pawn.create(
				x_coordinate: 1,
				y_coordinate: 4,
				game: @game,
				color: "black"
			)
			expect(@black_rook.obstructed_vertically?(1,3)).to eq true
		end

		describe "tests 'obstructed_diagonally' method," do
			it "should return true if there is a diagonal obstruction going up and to the right" do
				@black_queen = Queen.create(
					x_coordinate: 2,
					y_coordinate: 2,
					game: @game,
					color: "black"
				)
				@black_pawn = Pawn.create(
					x_coordinate: 3,
					y_coordinate: 3,
					game: @game,
					color: "black"
				)
				expect(@black_queen.obstructed_diagonally?(4,4)).to eq true
			end

			it "should return true if there is a diagonal obstruction going up and to the left" do
				@black_queen = Queen.create(
					x_coordinate: 3,
					y_coordinate: 3,
					game: @game,
					color: "black"
				)
				@black_pawn = Pawn.create(
					x_coordinate: 2,
					y_coordinate: 4,
					game: @game,
					color: "black"
				)
				expect(@black_queen.obstructed_diagonally?(1,5)).to eq true
			end

			it "should return true if there is a diagonal obstruction going down and to the right" do
				@black_queen = Queen.create(
					x_coordinate: 1,
					y_coordinate: 7,
					game: @game,
					color: "black"
				)
				@black_pawn = Pawn.create(
					x_coordinate: 2,
					y_coordinate: 6,
					game: @game,
					color: "black"
				)
				expect(@black_queen.obstructed_diagonally?(3,5)).to eq true
			end

			it "should return true if there is a diagonal obstruction going down and to the left" do
				@black_queen = Queen.create(
					x_coordinate: 7,
					y_coordinate: 7,
					game: @game,
					color: "black"
				)
				@black_pawn = Pawn.create(
					x_coordinate: 6,
					y_coordinate: 6,
					game: @game,
					color: "black"
				)
				expect(@black_queen.obstructed_diagonally?(5,5)).to eq true
			end

		end
	end

		#
    # it "should return 'TRUE' if there is a piece ON THE WAY to the destination coordinate moving DIAGNOALLY RIGHT + UP" do
    # 	black_bishop = Bishop.create(
    # 		x_coordinate: 2,
		# 		y_coordinate: 2,
		# 		game: @game,
		# 		color: "black"
  	# 	)
  	# 	white_knight = Knight.create(
  	# 		x_coordinate: 3,
		# 		y_coordinate: 3,
		# 		game: @game,
		# 		color: "white"
		# 	)
    # 	expect(black_bishop.is_obstructed?(5,5)).to eq true
  	# end
		#
    # it "should return 'TRUE' if there is a piece ON THE WAY to the destination coordinate moving DIAGNOALLY RIGHT + DOWN" do
    # 	black_bishop = Bishop.create(
    # 		x_coordinate: 1,
		# 		y_coordinate: 7,
		# 		game: @game,
		# 		color: "black"
  	# 	)
  	# 	white_knight = Knight.create(
  	# 		x_coordinate: 2,
		# 		y_coordinate: 6,
		# 		game: @game,
		# 		color: "white"
		# 	)
    # 	expect(black_bishop.is_obstructed?(3,5)).to eq true
  	# end
		#
  	# it "should return 'TRUE' if there is a piece ON THE WAY to the destination coordinate moving DIAGNOALLY LEFT + UP" do
    # 	black_bishop = Bishop.create(
    # 		x_coordinate: 7,
		# 		y_coordinate: 1,
		# 		game: @game,
		# 		color: "black"
  	# 	)
  	# 	white_knight = Knight.create(
  	# 		x_coordinate: 6,
		# 		y_coordinate: 2,
		# 		game: @game,
		# 		color: "white"
		# 	)
    # 	expect(black_bishop.is_obstructed?(5,3)).to eq true
  	# end
		#
  	# it "should return 'TRUE' if there is a piece ON THE WAY to the destination coordinate moving DIAGNOALLY LEFT + DOWN" do
    # 	black_bishop = Bishop.create(
    # 		x_coordinate: 6,
		# 		y_coordinate: 6,
		# 		game: @game,
		# 		color: "black"
  	# 	)
  	# 	white_knight = Knight.create(
  	# 		x_coordinate: 5,
		# 		y_coordinate: 5,
		# 		game: @game,
		# 		color: "white"
		# 	)
    # 	expect(black_bishop.is_obstructed?(4,4)).to eq true
  	# end
end
