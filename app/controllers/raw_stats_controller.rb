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
        overs = player.bowling_score_cards.overs
        individual[:name] = player.display_name
        individual[:runs] = player.batting_score_cards.score
        individual[:fours] = player.batting_score_cards.fours
        individual[:sixes] = player.batting_score_cards.sixes
        individual[:wickets] = player.bowling_score_cards.wickets
        individual[:overs] = overs
        individual[:extras] = player.bowling_score_cards.extras
        individual[:maidens] = player.bowling_score_cards.maidens
        individual[:country] = player.country.name
        individual[:matches] = player.batting_score_cards.matches
        individual[:conceded] = player.bowling_score_cards.runs
        overs = overs.floor + ((overs.modulo(1) * 100).round.to_f / 10) / 6.0
        individual[:economy_rate] = (overs > 0) ? ((player.bowling_score_cards.runs.to_f / overs.to_f) * 100).round.to_f / 100 : 0
        @players.push(individual)
      end
    end

    if(params[:country] and params[:country] != 'all')
      country_players = Array.new
      @players.each do |player|
        if player[:country] == params[:country]
          country_players.push(player)
        end
      end
      @players = country_players
    end
    sort = params[:sort]? params[:sort].to_sym : :name
    @players = @players.sort_by {|player| player[sort]}
    if params[:direction] == 'desc'
      @players = @players.reverse
    end
  end
end
