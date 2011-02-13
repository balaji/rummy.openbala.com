class TrendsController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
    render :text => "this is hardcore.", :layout => "standard"
  end
end
