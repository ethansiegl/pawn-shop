class GamesController < ApplicationController


	def index
		@games = Game.all
	end

	def new
		@game = Game.new
	end

	def create
		@game = Game.create(game_params)
		@game.set_white_player(current_user.id)
		redirect_to game_path(@game)
	end

	def show
		@game = Game.find(params[:id])
		
	end

	def update
		@game = Game.find(params[:id])		
		@game.set_black_player(current_user.id)
		redirect_to game_path(@game)
	end

	private
	
	def game_params
		params.require(:game).permit(:name, :white_player_id, :black_player_id)
	end


end
