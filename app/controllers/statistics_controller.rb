class StatisticsController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
    @countries = Country.find(:all, :conditions => "name != 'TBC'")
  end
end
