class AddSeries < ActiveRecord::Migration
  def self.up
    add_column(:matches, :series, :string)
  end

  def self.down
    remove_column(:matches, :series)
  end
end
