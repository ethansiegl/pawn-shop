require 'rails_helper'

RSpec.describe Rook, :type => :model do
  before :each do
    @game = Game.new
    @game.pieces.each(&:delete)
    @white_rook = Rook.create(
      x_coordinate: 2,
      y_coordinate: 2,
      game: @game,
      color: "white"
    )
  end

  describe "valid move for Rook piece" do
    it "should return true if Rook moves three squares vertically" do
      expect(@white_rook.valid_move?(2, 5)).to eq true
    end

    it "should return false if Rook movement is invalid" do
    	expect(@white_rook.valid_move?(5,5)).to eq false
    end

    it "should return false if Rook movement is obstructed" do
    	@white_pawn = Pawn.create(
    		x_coordinate: 2,
    		y_coordinate: 4,
    		game: @game,
    		color: "white"
    		)
    	expect(@white_rook.valid_move?(2,5)).to eq false
    end

    it "should return true if Rook is trying to capture opponent" do
      @black_pawn = Pawn.create(
        x_coordinate: 2,
        y_coordinate: 6,
        game: @game,
        color: "black"
        )
      expect(@white_rook.valid_move?(2,6)).to eq true
    end

    it "should return false if Rook movement is off board" do
      expect(@white_rook.valid_move?(15,2)).to eq false
    end

    it "should return false if Rook doesn't move" do
      expect(@white_rook.valid_move?(2,2)).to eq false
    end
	end
end
