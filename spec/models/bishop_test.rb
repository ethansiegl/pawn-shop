require "rails_helper"

RSpec.describe Piece, :type => :model do
	before :each do
		@game = Game.create
		@game.pieces.each(&:delete)
		@white_bishop = Bishop.create(
			x_coordinate: 1,
			y_coordinate: 1,
			game: @game,
			color: "white"
			)
		end
	describe "tests Bishop valid_move method" do
		it "should return false if move is vertical" do
			expect(@white_bishop.valid_move?(1,6)).to eq false
		end

		it "should return true if move is diagonal" do
			expect(@white_bishop.valid_move?(3,3)).to eq true
		end

		it "should return false if move is not on board" do
			expect(@white_bishop.valid_move?(15,15)).to eq false
		end

		it "should return false if there is no move" do
			expect(@white_bishop.valid_move?(1,1)).to eq false
		end

		it "should return false if move is obstructed" do
			@black_bishop = Bishop.create(
			x_coordinate: 2,
			y_coordinate: 2,
			color: "black"
			)
			expect(@white_bishop.valid_move?(3,3)).to eq false
		end

	end
end
