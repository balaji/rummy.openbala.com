class CreatePlayerMatchPoints < ActiveRecord::Migration
  def self.up
    create_table :player_match_points do |t|
      t.references :match
      t.references :player
      t.integer :points
      t.timestamps
    end
  end

  def self.down
    drop_table :player_match_points
  end
end
