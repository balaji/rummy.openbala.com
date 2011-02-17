class ResultsController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
    page = params[:page]? params[:page] : 1;
    @users = User.paginate(:page => page, :conditions => ['total_points > 0'], :order => 'total_points DESC')
  end
end
