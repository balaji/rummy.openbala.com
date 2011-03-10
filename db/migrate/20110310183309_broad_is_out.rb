class BroadIsOut < ActiveRecord::Migration
  def self.up
    broad = Player.find_by_display_name('Stuart Broad')
    broad.player_status = 'retired'
    broad.save!
  end

  def self.down
    broad = Player.find_by_display_name('Stuart Broad')
    broad.player_status = 'active'
    broad.save!
  end
end
