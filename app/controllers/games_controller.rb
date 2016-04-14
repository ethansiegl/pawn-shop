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
		#@game.set_black_player(current_user.id)

		#respond_to do | format |
		#	format.html { redirect_to game_path }
		#	format.json { render 'update.js.erb' }
		#end
	end


	private

	helper_method :current_game

	def game_params
		params.require(:game).permit(:name, :white_player_id, :black_player_id)
	end

	def current_game
		@game ||= Game.find(params[:id])
	end


end
