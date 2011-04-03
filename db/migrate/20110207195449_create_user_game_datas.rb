class CreateUserGameDatas < ActiveRecord::Migration
  def self.up
    create_table :user_game_datas do |t|
      t.references :user
      t.references :match
      t.references :daily_game

      t.timestamps
    end
  end

  def self.down
    drop_table :user_game_datas
  end
end
