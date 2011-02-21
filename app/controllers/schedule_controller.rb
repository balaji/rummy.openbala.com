class ScheduleController < ApplicationController
  before_filter :authenticate
  layout "standard"
#  caches_action :index

  def index
    @schedule = Match.all.sort_by { |s| s.date }
  end
end
