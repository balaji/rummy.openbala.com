class AlterUserGameData < ActiveRecord::Migration
  def self.up
    add_column(:user_game_datas, :player_order, :string)
  end

  def self.down
    remove_column(:user_game_datas, :player_order)
  end
end
