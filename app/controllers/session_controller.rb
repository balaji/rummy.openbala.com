class SessionController < ApplicationController
  before_filter :authenticate, :except => :create
  def create
    auth = request.env['rack.auth']
    unless @auth = Authorization.find_from_hash(auth)
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    self.current_user = @auth.user
    redirect_to :controller => 'session', :action => 'index'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def index
  end
end
