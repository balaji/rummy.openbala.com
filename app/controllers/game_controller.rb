class GameController < ApplicationController
  before_filter :authenticate
  layout "standard"
  def index
    @latest_matches = Match.find(:all, :conditions => ['date >= ? and date <= ? and match_status = ?', Time.now, 3.days.from_now, 'active'])
  end

  def play
    id = params[:match]
    @match = Match.find_by_id(id)
  end
end
