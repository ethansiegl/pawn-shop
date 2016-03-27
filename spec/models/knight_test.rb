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
  end

end
