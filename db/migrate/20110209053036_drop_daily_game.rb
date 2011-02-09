class DropDailyGame < ActiveRecord::Migration
  def self.up
    drop_table :daily_games
  end

  def self.down
    create_table :daily_games do |t|
      t.references :match
      t.string :player_thread
      t.integer :points

      t.timestamps
    end
  end
end
