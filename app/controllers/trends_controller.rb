class TrendsController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
    @matches = Match.find(:all, :conditions => ['date <= ?', Time.now])
  end
end
