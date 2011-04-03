class AlterUserGameData2 < ActiveRecord::Migration
  def self.up
    remove_column(:user_game_datas, :daily_game_id)
  end

  def self.down
    add_column(:user_game_datas, :daily_game_id, :integer)
  end
end
