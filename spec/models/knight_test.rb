require "rails_helper"

RSpec.describe Knight, type: :model do
  before :each do
    @game = Game.new
    @white_knight = Knight.create(
      x_coordinate: 1,
      y_coordinate: 2,
      game: @game,
      color: "white"
    )
  end

  describe "valid move for knight" do
    it "should return true if the knight moves two horizontal spaces and one vertical space" do
      expect(@white_knight.valid_move?(3, 3)).to eq true
    end

    it "should return true if the knight moves one horizontal space and two vertical spaces" do
      expect(@white_knight.valid_move?(2, 4)).to eq true
    end

    it "should return false if the knight makes an invalid move" do
      expect(@white_knight.valid_move?(2, 3)).to eq false
    end

    it "should return false if the knight stays in one place" do
      expect(@white_knight.valid_move?(1, 2)).to eq false
    end

    it "should return false if the knight moves off board" do
      expect(@white_knight.valid_move?(8,9)).to eq false
    end
  end

end
