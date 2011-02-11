class CreateBowlingScoreCards < ActiveRecord::Migration
  def self.up
    create_table :bowling_score_cards do |t|
      t.references :match
      t.references :player
      t.float :overs
      t.integer :maidens
      t.integer :runs
      t.integer :wickets
      t.integer :extras

      t.timestamps
    end
  end

  def self.down
    drop_table :bowling_score_cards
  end
end
