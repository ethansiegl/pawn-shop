require 'rails_helper'


RSpec.describe Game, type: :model do
	describe "setting up new board" do
		it "should set up new board with all the chess pieces" do 
			Game.new.initiate_new_board
			expect(Piece.count).to eq 32
		end
	end
end