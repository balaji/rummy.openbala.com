class MyspaceController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
    @matches = Match.find(:all, :conditions => ['date <= ? and match_type != ?',  3.days.from_now.in_time_zone('UTC'), 'Warm-Up']).sort_by {|m| m.date}.reverse
  end
end
