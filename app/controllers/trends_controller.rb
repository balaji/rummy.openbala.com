class TrendsController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
    @matches = Match.find(:all, :conditions => ['date < ?', Time.now.in_time_zone('Chennai') - 1.day])
  end

  def view
    match_id = params[:match]
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
    @player_points_one = PlayerMatchPoint.country_one(match_id).find_all { |p| p.points > 0 }.sort_by { |p| -p.points }
    @player_points_two = PlayerMatchPoint.country_two(match_id).find_all { |p| p.points > 0 }.sort_by { |p| -p.points }
  end
end
