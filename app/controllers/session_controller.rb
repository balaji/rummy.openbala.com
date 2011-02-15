class SessionController < ApplicationController
  before_filter :authenticate, :except => :create
  layout "standard"

  def create
    auth = request.env['rack.auth']
    self.token = auth["credentials"]["token"]
    unless @auth = Authorization.find_from_hash(auth)
      @auth = Authorization.create_from_hash(auth, self.fb_graph.get_picture("me"), current_user)
    end
    self.current_user = @auth.user
    redirect_to :action => 'index'
  end

  def destroy
    session[:user_id] = nil
    session[:token] = nil
    redirect_to root_path
  end

  def index
    @friends ||= self.fb_graph.get_connections("me", "friends")
  end
end
