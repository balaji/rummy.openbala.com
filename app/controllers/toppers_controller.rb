class ToppersController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate
  layout "standard"

  def index
  end

  def runs
    if Rails.env == "production"
      players = Rails.cache.read('players_raw_data')
    else
      players = stats
    end
    runs = players.sort_by do |player|
      -player[:runs]
    end
    render :json => runs.first(10)
  end

  def wickets
  end
end
