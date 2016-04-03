class PiecesController < ApplicationController

	def show
		@piece = Piece.find(params[:id])
	end

	def update
		current_piece.update(:x_coordinate => params[:row], y_coordinate => params[:column])
	end

	private

		helper_method :current_game, :current_piece

	def piece_params
		params.require(:piece).permit(:x_coordinate, :y_coordinate)
	end

	def current_game
		@current_game ||= Game.find(params[:game_id])
	end

	def current_piece
		@piece ||= Piece.find(params[:id])
	end

end
