class FeedbackController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index

    render :text => "feedback here..", :layout => 'standard'
  end
end
