class CurrentFormController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
    match_id = Match.find(:first, :conditions => ['Status = ?', 'finished'], :order => 'id desc').id
    user = CurrentForm.find_by_user_id_and_match_id(self.current_user.id, match_id)
    page = params[:page] ? params[:page] : (user.nil? ? user.rank / 10 + 1 : 1)
    @current_form = CurrentForm.paginate(:all, 
                                         :conditions=> ['match_id = ?', match_id], 
                                         :page => page, 
                                         :per_page => User.per_page)
  end

end
