class CreateDailyGames < ActiveRecord::Migration
  def self.up
    create_table :daily_games do |t|
      t.references :match
      t.string :player_thread
      t.integer :points

      t.timestamps
    end
  end

  def self.down
    drop_table :daily_games
  end
end
