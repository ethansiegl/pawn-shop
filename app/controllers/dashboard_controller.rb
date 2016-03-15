class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @my_games = my_games
    @open_games = open_games
  end

  def my_games

  end

  def open_games

  end 

end
