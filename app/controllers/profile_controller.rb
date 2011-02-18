class ProfileController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
    @my_data = UserGameData.find_all_by_user_id(self.current_user.id, :order => 'match_id')
    self.fb_graph.put_object("damodaran.balaji", "feed", :message => "I am writing this guy's my wall!")
  end
end
