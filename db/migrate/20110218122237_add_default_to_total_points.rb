class AddDefaultToTotalPoints < ActiveRecord::Migration
  def self.up
    change_column_default(:users, :total_points, 0)
  end

  def self.down
    change_column_default(:users, :total_points, nil)
  end
end
