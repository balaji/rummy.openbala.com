class AddTotalPointsToUser < ActiveRecord::Migration
  def self.up
    add_column(:users, :total_points, :integer)
  end

  def self.down
    remove_column(:users, :total_points)
  end
end
