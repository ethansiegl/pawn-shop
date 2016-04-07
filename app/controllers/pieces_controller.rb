class PiecesController < ApplicationController
	def show
		@piece = Piece.find(params[:id])
	end
	
	def update
		if current_piece.valid_move?(params[:row].to_i, params[:column].to_i)
			current_piece.move_to!(params[:row], params[:column])
			redirect_to game_path(current_game)
		else
			redirect_to game_path(current_game)
			flash[:alert] = "Invalid Move"
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