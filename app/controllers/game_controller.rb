class GameController < ApplicationController
  before_filter :authenticate
  def index
    user_game_data = UserGameData.find(:all, :conditions => ["match_id = ? and user_id = ?", params[:match], current_user.id])
    @game_data = if(user_game_data[0])
                   user_game_data[0]
                else 
                   UserGameData.new(:user_id => current_user.id, :match_id => params[:match])
                end
  end

  def update

  end
end
