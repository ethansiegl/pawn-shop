class PiecesController < ApplicationController
	
	def show
		@piece = Piece.find(params[:id])
	end

	def update
		@piece = Piece.find(params[:id])
		@piece = @piece.update_attributes(new_position_params)
	end
	
	private

	def new_position_params
		params.require(:piece).permit(:x_coordinate, :y_coordinate)
	end


end
