class UserGameData < ActiveRecord::Base
  belongs_to :user
  belongs_to :match
  belongs_to :daily_game
  
  def validate
    errors.add_to_base "Match information doesn't match!" if not match.id == daily_game.match.id
  end
end
