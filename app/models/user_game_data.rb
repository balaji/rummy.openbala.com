class UserGameData < ActiveRecord::Base
  belongs_to :user
  belongs_to :match
  validates_presence_of :player_order
  validates_uniqueness_of :user_id, :scope => [:match_id]

  def self.played(user_id, match_id)
    UserGameData.find_by_user_id_and_match_id(user_id, match_id)
  end
end
