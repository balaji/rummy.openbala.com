class ScheduleController < ApplicationController
#  before_filter :authenticate
  layout "standard"
#  caches_action :index

  def index
    @schedule = Match.find_all_by_series('cwc2011').sort_by { |s| s.date }
  end
end
