class ScheduleController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
    @schedule = Match.all.sort_by { |s| s.date }
  end
end
