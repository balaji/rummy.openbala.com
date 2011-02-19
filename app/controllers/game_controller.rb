class GameController < ApplicationController
  before_filter :authenticate, :init_me
  layout "standard"

  def init_me
    @latest_matches ||= Match.find(:all, :conditions => ['date >= ? and date <= ?', Time.now.in_time_zone('Chennai'), 3.days.from_now.in_time_zone('UTC')]).sort_by {|m| m.date}
  end

  def index
  end

  def play
    @match = Match.find_by_id(params[:match])
    render :text => "<div class=\"grid_3\">nice try</div>", :layout => "standard" if !@latest_matches.include?(@match)
    user_data = UserGameData.find_by_match_id_and_user_id(@match.id, self.current_user.id)
    @players_chosen = Array.new
    if (user_data)
      user_data.player_order.split(",").each do |id|
        @players_chosen.push(Player.find(id).display_name)
      end
    end
  end

  def save
    json_data = JSON.parse(params[:preferences])

    preference_map = Hash.new
    json_data.each do |key, value|
      order = /drop_(.*)/.match(key)[1]
      player_id = /player_(.*)/.match(value)[1]
      preference_map[order] = player_id
    end

    preferences = Array.new
    preference_map.sort.each { |x| preferences.push(x[1]) }
    user_data = UserGameData.find_by_match_id_and_user_id(params[:match_id], self.current_user.id)
    user_data = UserGameData.create(:match_id => params[:match_id], :user_id => self.current_user.id) unless user_data
    user_data.player_order = preferences.join(",")
    user_data.save!
    render :text => "success"
  end
end
