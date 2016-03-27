require "rails_helper"

RSpec.describe Knight, type: :model do
  before :each do
    @game = Game.new
    @white_knight = Knight.create(
      x_coordinate: 4,
      y_coordinate: 4,
      game: @game,
      color: "white"
    )
  end

  describe "valid move for knight" do
    it "should return true if the knight makes valid move" do
      expect(@white_knight.valid_move?(6, 5)).to eq true
    end

    it "should return true if the knight makes a different valid move" do
      expect(@white_knight.valid_move?(3, 6)).to eq true
    end

    it "should return false if the knight makes an invalid move" do
      expect(@white_knight.valid_move?(3,3)).to eq false
    end

    it "should return false if the knight stays in one place" do
      expect(@white_knight.valid_move?(4,4)).to eq false
    end
  end

end
