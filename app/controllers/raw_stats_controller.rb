class RawStatsController < ApplicationController
  include ApplicationHelper
#  before_filter :authenticate
  layout "standard"

  def index
      @players = stats

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
