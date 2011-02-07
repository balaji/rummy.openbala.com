class DailyGame < ActiveRecord::Base
  belongs_to :match
  has_many :user_game_data
end
