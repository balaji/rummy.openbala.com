class ToppersController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate
  layout "standard"

  def index
  end

  def toppers
    if Rails.env == "production"
      players = Rails.cache.read('players_raw_data')
    else
      players = stats
    end
    
    runs = players.sort_by do |player|
      -player[:runs]
    end
    
    wickets = players.sort_by do |player|
      -player[:wickets]
    end

    points = players.sort_by do |player|
      -player[:points]
    end
    jumbo = Hash.new
    jumbo[:top_runs] = runs.first(10)
    jumbo[:top_wickets] = wickets.first(10)
    jumbo[:top_points] = points.first(10)

    render :json => jumbo
  end
end
