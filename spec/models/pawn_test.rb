require 'rails_helper'

RSpec.describe Pawn, type: :model do
  before :each do
    @game = Game.new
    @game.pieces.each(&:delete)
    @white_pawn = Pawn.create(
      x_coordinate: 2,
      y_coordinate: 2,
      game: @game,
      color: "white"
    )
  end

  describe "valid move for Pawn piece" do

     it "should return false if move is out of the board" do
      expect(@white_pawn.valid_move?(2,10)).to eq false
    end


    it "should return true if Pawn moves one square vertically" do
      expect(@white_pawn.valid_move?(2, 3)).to eq true
    end

    it "should return false if Pawn moves more than one square" do
      expect(@white_pawn.valid_move?(2,6)).to eq false
    end

     it "should return true if Pawn moves two squares on first turn" do
      expect(@white_pawn.valid_move?(2,4)).to eq true
    end


    it "should return false if Pawn moves two squares on second turn" do
      @white_pawn = Pawn.create(
        x_coordinate: 2,
        y_coordinate: 4,
        game: @game,
        color: "white"
        )
      expect(@white_pawn.valid_move?(2,6)).to eq false
    end

    it "should return false if White Pawn moves backward" do
      expect(@white_pawn.valid_move?(2,1)).to eq false
    end

    it "should return false if Pawn moves horizontally" do
      expect(@white_pawn.valid_move?(5,2)).to eq false
    end

    it "should return false if Pawn moves diagonally" do
      expect(@white_pawn.valid_move?(4,4)).to eq false
    end


    it "should return true if Pawn can capture an opponent diagonally in one move" do
      @black_pawn = Pawn.create(  
        x_coordinate: 3,
        y_coordinate: 3,
        game: @game,
        color: "black"
        )
      expect(@white_pawn.valid_move?(3,3)).to eq true
    end

    it "return true if Pawn can capture an opponent diagonally in one move when it is not the first move" do
      @black_pawn = Pawn.create(  
        x_coordinate: 4,
        y_coordinate: 5,
        game: @game,
        color: "black"
        )
      @whitepawn = Pawn.create(  
        x_coordinate: 5,
        y_coordinate: 4,
        game: @game,
        color: "white"
        )
      expect(@whitepawn.valid_move?(4,5)).to eq true
    end



    it "should return false if Pawn stays in one place" do
      expect(@white_pawn.valid_move?(2,2)).to eq false
    end

  
  it "should return false since the pawn isn't on the last square of the board" do
    @blackpawn = Pawn.create(
      x_coordinate: 7,
      y_cooridnate: 8,
      game: @game,
      color: "black"
      )
    expect(@blackpawn.can_be_promoted?(7,6)).to eq false
  end


end
