class PiecesController < ApplicationController

	def update
		@piece = Piece.find(params[:id])
		@piece = @piece.update_attributes(new_position_params)
	end
	
	private

	def new_position_params
		params.require(:piece).permit(:x_coordinate, :y_coordinate)
	end

	# def current_game
	# 	@current_game ||= Game.find(params[:id])
	# end
end
