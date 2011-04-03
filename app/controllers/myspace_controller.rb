class MyspaceController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
    @matches = Match.find(:all, :conditions => ['date <= ? and match_type != ? and country_one_id != ?',  3.days.from_now.in_time_zone('UTC'), 'Warm-Up', 15]).sort_by {|m| m.date}.reverse
  end
end
