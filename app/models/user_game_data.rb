class UserGameData < ActiveRecord::Base
  belongs_to :user
  belongs_to :match
  validates_presence_of :player_order
end
