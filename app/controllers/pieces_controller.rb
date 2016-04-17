class PiecesController < ApplicationController


	def show
		@piece = Piece.find(params[:id])
		#render :template => "games/show"
	end


	def update
	  if current_piece.valid_move?(params[:x].to_i, params[:y].to_i)
	    current_piece.move_to!(params[:x], params[:y])
			respond_to do | format |
				format.html { render :show }
				format.json { render json: { update_url: game_path(current_game) } }
			end
	  else
	    flash.now[:alert] = "Invalid Move"
			respond_to do | format |
				format.html { render :nothing => true }
			end
	  end
	end

	def promote_pawn
		
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
