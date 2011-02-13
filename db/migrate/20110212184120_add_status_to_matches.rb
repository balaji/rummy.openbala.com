class AddStatusToMatches < ActiveRecord::Migration
  def self.up
    add_column(:matches, :match_status, :string)
  end

  def self.down
    remove_column(:matches, :match_status)
  end
end
