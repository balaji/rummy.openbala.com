class SessionController < ApplicationController
 # before_filter :authenticate, :except => :create
  layout "standard", :except => :promo

  def create
    auth = request.env['rack.auth']
    self.token = auth["credentials"]["token"] if auth["provider"] == 'facebook'
    unless @auth = Authorization.find_from_hash(auth)
      picture_url = self.fb_graph.get_picture("me") if auth["provider"] == 'facebook'
      picture_url = auth["user_info"]["image"] if auth["provider"] == 'twitter'
      @auth = Authorization.create_from_hash(auth, picture_url, current_user)
    end
    self.current_user = @auth.user
    self.current_auth = @auth
    if (@auth.provider == 'facebook')
      ids = Array.new
      self.fb_graph.get_connections("me", "friends").each do |friend| 
        ids.push(friend["id"])
      end
#      self.set_friends(Authorization.find(:all, :conditions => ["uid in (?)", ids]))
    end
    redirect_to :action => 'promo'
  end

  def destroy
    session[:user_id] = nil
    session[:token] = nil
    session[:friend_ids] = nil
    session[:uid] = nil
    redirect_to root_path
  end

  def promo
    render :layout => "no-menu"
  end

  def index
  end

  def save
    IplMailer.deliver_send(request, self.current_user.name)
    render :text => "<div class='grid_12' align='center'>Thanks for your feedback, much appreciated :)</div><div class='grid_3'>&nbsp;</div><img alt='Ipl4' class='grid_6' src='/images/ipl4.jpg' />", :layout => "standard"
  end
end
