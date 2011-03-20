class IplController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
  end

  def save
    IplMailer.deliver_send(request, self.current_user.name)
    redirect_to :action => 'index'
  end
end
