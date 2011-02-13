class ScheduleController < ApplicationController
  before_filter :authenticate
  layout "standard"
  def index
    @schedule = Match.all
  end
end
