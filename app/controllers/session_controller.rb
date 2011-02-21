class SessionController < ApplicationController
  before_filter :authenticate, :except => :create
  layout "standard"
#  caches_action :index

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
    session[:friend_ids] = nil
    redirect_to root_path
  end

  def index
    my_friends ||= self.fb_graph.get_connections("me", "friends")
    ids = Array.new
    my_friends.each { |friend| ids.push(friend["id"]) }
    authorizationz = Authorization.find(:all, :conditions => ["uid in (?)", ids])
    self.set_friends(authorizationz)
    page = params[:page]? params[:page] : 1;
    @authorizations = authorizationz.paginate(:page => page, :per_page => Authorization.per_page)
  end
end
