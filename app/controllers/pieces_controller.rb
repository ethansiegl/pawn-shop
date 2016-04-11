class PiecesController < ApplicationController


	def show
		@piece = Piece.find(params[:id])
	end


	def update
		if current_piece.valid_move?(params[:x].to_i, params[:y].to_i)
			current_piece.move_to!(params[:x], params[:y])
			 render text: 'updated!'
		else
			flash.now[:alert] = "Invalid Move"
			render '/games/current_game'
		end
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
