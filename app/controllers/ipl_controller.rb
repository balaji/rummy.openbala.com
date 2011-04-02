class IplController < ApplicationController
  layout "no-menu"

  def stadia
    @stadia = Stadium.ipl_stadia
  end

  def stadium
    mths = Match.find(:all, :conditions => ['stadium_id = ? and series = ?', Stadium.find_by_city(params[:city]).id, 'ipl4'])
    json = ActiveSupport::JSON
    matches = Array.new
    mths.each do |match|
      matches.push(json.encode({
        :team_one => match.country_one.name,
        :team_two => match.country_two.name,
        :date => match.date.strftime("%d/%m, %a") 
      }))
    end
    render :json => matches
  end

  def teams
    @teams = Country.ipl_teams
  end

  def index
  end

  def schedule
    @schedule = Match.find_all_by_series('ipl4').sort_by { |s| s.date }
  end

  def teams
  end

  def soon
    render :text => '<span align="center" class="grid_12 graublau zoom inner_shadow">Coming Soon...</span>', :layout => "no-menu"
  end
end
