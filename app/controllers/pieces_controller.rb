class PiecesController < ApplicationController

	def show
		@piece = Game.Piece.find(params[:id])
	end

	def update
		current_piece.update(:x_coordinate => params[:row], :y_coordinate => params[:column])
		render text: 'Next Move!'
	end

	def current_game
		@current_game ||= Game.find(params[:game_id])
	end

	def current_piece
		@piece ||= Piece.find(params[:id])
	end

	private

		helper_method :current_game, :current_piece

	def piece_params
		params.require(:piece).permit(:x_coordinate, :y_coordinate)
	end

end
