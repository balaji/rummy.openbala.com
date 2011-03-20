class IplController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
  end

  def save
    IplMailer.deliver_send
    redirect_to :action => 'index'
  end
end
