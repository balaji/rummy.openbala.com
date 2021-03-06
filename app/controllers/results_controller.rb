class ResultsController < ApplicationController
  #before_filter :authenticate, :init_me
  before_filter :init_me
  layout "standard"

  def index
  end

  def all
    page = params[:page]
    @users = User.paginate(:page => page, :conditions => ['total_points > 0'], :order => 'total_points DESC')
    @user_ranks = Array.new
    User.per_page.times { |i| @user_ranks.push((User.per_page * (page.to_i - 1)) + i + 1) }

    render :index
  end

  def friend
    page = params[:page]
    @user_friends = @friends_list.paginate(:page => page, :per_page => User.per_page)
    @friend_ranks = Array.new
    User.per_page.times { |i| @friend_ranks.push((User.per_page * (page.to_i - 1)) + i + 1) }

    render :index
  end

  private
  def init_me
      @rank ||= if self.signed_in? and self.current_user.total_points > 0
        User.all.sort_by {|u| -u.total_points}.index(self.current_user) + 1 
      else
        'NA'
      end
    page = (@rank != 'NA')? ((@rank.to_i - 1) / 10) + 1 : 1
    @users = User.paginate(:page => page, :conditions => ['total_points > 0'], :order => 'total_points DESC')
    @user_ranks = Array.new
   User.per_page.times { |i| @user_ranks.push((User.per_page * (page.to_i - 1)) + i + 1) }

    if (self.signed_in? and self.current_auth.provider == 'facebook')
      @friends_list ||= my_friends.sort_by { |friend| [-friend.total_points.to_i, friend.name] }
      @user_friends = @friends_list.paginate(:page => 1, :per_page => User.per_page)

      @friend_ranks = Array.new
      User.per_page.times { |i| @friend_ranks.push(i + 1) }
    end
  end

  private
  def my_friends
    fri = Array.new
    self.friends.each do |authorization|
      fri.push(authorization.user)
    end
    fri.push(self.current_user)
    fri
  end
end
