class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def my_games
    if user_signed_in?
      @my_games = Game.
    end
  end

  def open_games
    if user_signed_in?
      @open_games = Game.where(black_player_id = nil &&
    end
  end

end
