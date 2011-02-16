class RemoveStatusFromMatches < ActiveRecord::Migration
  def self.up
    remove_column(:matches, :match_status)
  end

  def self.down
    add_column(:matches, :match_status, :string)
  end

end
