class ResultsController < ApplicationController
  before_filter :authenticate, :init_me
  layout "standard"

  def index
  end

  def all
    page = params[:page]
    @users = User.paginate(:page => page, :order => 'total_points DESC')
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
    @users = User.paginate(:page => 1, :order => 'total_points DESC')
    @user_ranks = Array.new
    User.per_page.times { |i| @user_ranks.push(i + 1) }

    @friends_list ||= my_friends.sort_by { |friend| [-friend.total_points.to_i, friend.name] }
    @user_friends = @friends_list.paginate(:page => 1, :per_page => User.per_page)

    @friend_ranks = Array.new
    User.per_page.times { |i| @friend_ranks.push(i + 1) }
  end

  private
  def my_friends
    fri = Array.new
    self.friends.each do |user|
      fri.push(user)
    end
    fri.push(self.current_user)
    fri
  end
end
