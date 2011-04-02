class AddIplPlayers < ActiveRecord::Migration
  def self.up
    add_column(:players, :ipl_country_id, :string)
  end

  def self.down
    remove_column(:players, :ipl_country_id)
  end
end
