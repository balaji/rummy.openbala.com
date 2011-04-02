class StatisticsController < ApplicationController
#  before_filter :authenticate
  layout "standard"

  def index
  end

  def country_stats
    players = Player.find_all_by_country_id(params[:country_id])
    json = ActiveSupport::JSON
    playas = Array.new
    players.each do |player|
      playas.push(json.encode({ :name => player.display_name, 
                    :score => player.batting_score_cards.score,
                    :points => player.player_match_points.total,
                    :wickets => player.bowling_score_cards.wickets}))
    end
    render :json => playas
  end
end
