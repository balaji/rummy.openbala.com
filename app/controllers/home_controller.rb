class HomeController < ApplicationController
  def index
    redirect_to :controller => 'session', :action => 'index' if signed_in?
  end
end
