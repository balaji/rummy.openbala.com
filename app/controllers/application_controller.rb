class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  protected
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  protected
  def current_auth
    @current_auth ||= Authorization.find_by_uid(session[:uid])
  end

  protected
  def fb_graph
    @graph ||= Koala::Facebook::GraphAPI.new(session[:token])
  end

  def authenticate
    redirect_to root_path unless signed_in?
  end

  def friends
    if Rails.env == "production"
      Rails.cache.read("#{session[:user_id]}_friends")
    else
      ids = Array.new
      fb_graph.get_connections("me", "friends").each do |friend| 
        ids.push(friend["id"])
      end
      Authorization.find(:all, :conditions => ["uid in (?)", ids])
    end
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :friends, :signed_in?, :fb_graph, :current_auth
  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
    session[:rank] = if self.current_user.total_points > 0
      User.all.sort_by {|u| -u.total_points}.index(self.current_user) + 1 
    else
      'NA'
    end
  end

  def current_auth=(auth)
    @current_auth = auth
    session[:uid] = auth.uid
  end

  def set_friends(friends)
    Rails.cache.delete("#{session[:user_id]}_friends")
    Rails.cache.fetch("#{session[:user_id]}_friends") { friends }
  end

  def token=(token)
    @graph = Koala::Facebook::GraphAPI.new(token)
    session[:token] = token
  end
end
