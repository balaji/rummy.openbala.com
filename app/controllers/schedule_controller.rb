class ScheduleController < ApplicationController
  before_filter :authenticate
  def index
    @schedule = Match.all
  end
end
