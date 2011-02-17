class UserGameData < ActiveRecord::Base
  belongs_to :user
  belongs_to :match
  validates_presence_of :player_order
  validates_uniqueness_of :user_id, :scope => [:match_id]
end
