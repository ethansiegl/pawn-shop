class GamesController < ApplicationController


	def index
		@games = Game.all
	end

	def new
		@game = Game.new
	end

	def create
		@game.create(:white_player_id => current_user.id, :black_player_id => nil)
		redirect_to game_path(@game)
	end

	def show
		@game = Game.find(params[:id])
	end

	private

	def game_params
		params.require(:game).permit(:game_id, :white_player_id, :black_player_id)
	end

end
