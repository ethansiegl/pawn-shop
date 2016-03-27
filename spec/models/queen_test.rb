require 'rails_helper'

RSpec.describe Queen, type: :model do
  before :each do
    @game = Game.new
    @white_queen = Queen.create(
      x_coordinate: 5,
      y_coordinate: 4,
      game: @game,
      color: "white"
    )
  end

  describe "should return true if queen move is valid" do
    it "should return true if the queen move is valid" do
      expect(@white_queen.valid_move?(5, 7)).to eq true
    end
  end
end
