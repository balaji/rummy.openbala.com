class AddPointsToUserGameData < ActiveRecord::Migration
  def self.up
    add_column(:user_game_datas, :points, :integer)
  end

  def self.down
    remove_column(:user_game_datas, :points)
  end
end
