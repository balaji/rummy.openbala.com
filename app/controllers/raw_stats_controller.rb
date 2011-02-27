class RawStatsController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
    @players = Rails.cache.fetch('players_raw_data')
    sort = params[:sort]? params[:sort].to_sym : :name
    @players = @players.sort_by {|player| player[sort]}.reverse
  end
end
