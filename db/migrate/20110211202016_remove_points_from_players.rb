class RemovePointsFromPlayers < ActiveRecord::Migration
  def self.up
    remove_column(:players, :points)
  end

  def self.down
    add_column(:players, :points, :integer)
  end
end
