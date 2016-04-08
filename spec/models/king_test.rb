require 'rails_helper'

RSpec.describe King, type: :model do
  before :each do
    @game = Game.new
    @white_king = King.create(
      x_coordinate: 2,
      y_coordinate: 2,
      game: @game,
      color: "white"
    )
  end

  describe "valid move for King piece" do
    it "should return true if King moves one square horizontially" do
      expect(@white_king.valid_move?(2, 1)).to eq true
    end

    it "should return true is King moves one square diagonally" do
      expect(@white_king.valid_move?(3,3)).to eq true
    end

    it "should return false if King moves more than one square" do
      expect(@white_king.valid_move?(6,7)).to eq false
    end

    it "should return false if King stays in one place" do
      expect(@white_king.valid_move?(2,2)).to eq false
    end

    it "should return false if King moves more than one square in one direction" do
      expect(@white_king.valid_move?(3,7)).to eq false
    end
  end


end
