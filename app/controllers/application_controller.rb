# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  protected
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  protected
  def fb_graph
    @graph ||= Koala::Facebook::GraphAPI.new(session[:token])
  end

  def authenticate
    redirect_to root_path unless signed_in?
  end

  def friends
    if (!@authorizations)
      my_friends = self.fb_graph.get_connections("me", "friends")
      ids = Array.new
      my_friends.each { |friend| ids.push(friend["id"]) }
      @authorizations = Authorization.find(:all, :conditions => ["uid in (?)", ids])
    else
      @authorizations
    end
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?, :fb_graph

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def set_friends(friends)
    @authorizations = friends
#    session[:friend_ids] = ids
  end

  def token=(token)
    @graph = Koala::Facebook::GraphAPI.new(token)
    session[:token] = token
  end
end
