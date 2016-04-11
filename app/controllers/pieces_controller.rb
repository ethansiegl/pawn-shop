class PiecesController < ApplicationController
	def show
		@piece = Piece.find(params[:id])
	end
	
	def update
		# current_piece.update(:x_coordinate => params[:x], :y_coordinate => params[:y])
		# render text: 'updated!'

		if current_piece.valid_move?(params[:x].to_i, params[:y].to_i)
			current_piece.move_to!(params[:x], params[:y])
			render text: 'updated!'
		else
			flash.now[:alert] = "Invald Move"
			render '/games/current_game'
			# redirect_to game_path(current_game)
			# flash[:alert] = "Invalid Move"
		end
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
	