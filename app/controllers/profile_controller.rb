class ProfileController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
      @matches ||= Match.find(:all, :conditions => ['date < ? and match_type != ?', Time.now.in_time_zone('Chennai') - 8.hours, 'Warm-Up']).sort_by { |m| m.date }
  end

  def user_game_data
    json = ActiveSupport::JSON
    user_points = Array.new
    UserGameData.find_all_by_match_id(params[:match_id]).sort_by { |u| -u.points }.each do |data|
      user_points.push(json.encode({:name => data.user.name, :points => data.points, :player_order => data.player_order}))
    end
    render :json => user_points
  end

  def player_profile
    json = ActiveSupport::JSON
    player_order = Array.new
    match_id = params[:match_id]
    @top_players ||= PlayerMatchPoint.find_all_by_match_id(match_id, :order => "points DESC", :limit => 5)
    params[:order].split(",").zip(@top_players).each do |id, player_match|
      pmr = PlayerMatchPoint.find_by_player_id_and_match_id(id, match_id)
      player_order.push(json.encode({:player => Player.find(id).display_name,
                                     :points => (pmr) ? pmr.points.to_i : "DNP",
                                     :top_player => player_match.player.display_name,
                                     :top_points => player_match.points}))
    end
    render :json => player_order
  end
end
