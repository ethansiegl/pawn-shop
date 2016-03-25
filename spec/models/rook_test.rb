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
    it "should return true if Rook moves one square horizontially" do
      expect(@white_rook.valid_move?(2, 5)).to eq true
    end

    it "should return false if Rook movement is invalid" do 
    	expect(@white_rook.valid_move?(5,5)).to eq false
    end

    it "should return false if Rook movement is obstrcted" do 
    	@white_pawn = Pawn.create(
    		x_coordinate: 2,
    		y_coordinate: 4,
    		game: @game,
    		color: "white"
    		)
    	expect(@white_rook.valid_move?(2,5)).to eq false
    end
	end
end