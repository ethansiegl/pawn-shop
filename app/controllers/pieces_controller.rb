class PiecesController < ApplicationController
	def show

	end
	


	private

	helper_method :current_game, :current_piece
	
	def current_game
		@current_game ||= Game.find(params[:game_id])
	end
	
	def current_piece
		@piece ||= Piece.find(params[:id])
	end

end
