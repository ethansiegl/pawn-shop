require 'rails_helper'

RSpec.describe Queen, type: :model do
  before :each do
    @game = Game.new
    @game.pieces.each(&:delete)
    @white_queen = Queen.create(
      x_coordinate: 5,
      y_coordinate: 4,
      game: @game,
      color: "white"
    )
  end

  describe "should return true if queen move is valid" do
    it "should return true if the queen moves vertically" do
      expect(@white_queen.valid_move?(5, 7)).to eq true
    end

    it "should return false if the queen move is invalid" do
      expect(@white_queen.valid_move?(1,1)).to eq false
    end

    it "should return false if the queen stays in the same place" do
      expect(@white_queen.valid_move?(5, 4)).to eq false
    end

    it "should return true if the queen move diagonally" do
      expect(@white_queen.valid_move?(6,5)).to eq true
    end
  end
end
