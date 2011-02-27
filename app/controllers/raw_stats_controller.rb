class RawStatsController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
    if Rails.env == "production"
      @players = Rails.cache.fetch('players_raw_data')
    else
      all_players = Player.all
      @players = Array.new
      all_players.each do |player|
        individual = Hash.new
        individual[:name] = player.display_name
        individual[:runs] = player.batting_score_cards.score
        individual[:fours] = player.batting_score_cards.fours
        individual[:sixes] = player.batting_score_cards.sixes
        individual[:wickets] = player.bowling_score_cards.wickets
        individual[:overs] = player.bowling_score_cards.overs
        individual[:extras] = player.bowling_score_cards.extras
        individual[:maidens] = player.bowling_score_cards.maidens
        individual[:country] = player.country.name
        individual[:matches] = player.batting_score_cards.matches
        @players.push(individual)
      end
    end
    sort = params[:sort]? params[:sort].to_sym : :name
    @players = @players.sort_by {|player| player[sort]}
    if params[:direction] == 'desc'
      @players = @players.reverse
    end
  end
end
