class GameController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
    @latest_matches = Match.find(:all, :conditions => ['date >= ? and date <= ?', Time.now.in_time_zone('UTC'), 3.days.from_now.in_time_zone('UTC')])
  end

  def play
    @match = Match.find_by_id(params[:match])
  end
end
