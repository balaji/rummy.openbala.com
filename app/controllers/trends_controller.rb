class TrendsController < ApplicationController
 # before_filter :authenticate, :init_me
  before_filter :init_me
  layout "standard"

  def init_me
    if params[:country].nil? or params[:country] == 'All'
      @matches ||= Match.find(:all, :conditions => ['status = ?', "finished"]).sort_by { |m| m.date }.reverse
    else
      @matches = Match.find(:all, 
                            :conditions => ['status = ? and (country_one_id = ? or country_two_id = ?)', 
                                            "finished", params[:country], params[:country]]).sort_by { |m| m.date }.reverse
    end
  end

  def index
  end

  def view
    match_id = params[:match]
    render :text => "<div class=\"grid_3\">nice try</div>", :layout => "standard" if !@matches.include?(Match.find(params[:match]))
    @batting_country_one = BattingScoreCard.country_one(match_id)
    @batting_country_two = BattingScoreCard.country_two(match_id)
    @bowling_country_one = BowlingScoreCard.country_one(match_id)
    @bowling_country_two = BowlingScoreCard.country_two(match_id)
    MatchTotal.find_all_by_match_id(match_id).each do |mt|
      if mt.country.name == @batting_country_one[0].player.country.name
        @mt1 = mt
      else
        @mt2 = mt
      end
    end
    @player_points_one = PlayerMatchPoint.country_one(match_id).find_all.sort_by { |p| -p.points }
    @top_players = PlayerMatchPoint.country_two(match_id).find_all.sort_by { |p| -p.points }
  end
end
