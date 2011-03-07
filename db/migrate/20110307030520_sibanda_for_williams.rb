class SibandaForWilliams < ActiveRecord::Migration
  def self.up
    williams = Player.find_by_display_name('Sean Williams')
    williams.player_status = "retired"
    williams.save!

    ed = Player.find_by_display_name('Ed Rainsford')
    ed.player_status = "retired"
    ed.save!

    Player.create!(:display_name => 'Vusi Sibanda', :short_name => 'V Sibanda', :country_id => 14, :role => 'BAT', :player_status => 'active')
    Player.create!(:display_name => 'Michael Hussey', :short_name => 'MEK Hussey', :country_id => 1, :role => 'BAT', :player_status => 'active')
    Player.create!(:display_name => 'Dirk Nannes', :short_name => 'DP Nannes', :country_id => 1, :role => 'BWL', :player_status => 'active')
    Player.create!(:display_name => 'Chris Tremlett', :short_name => 'CT Tremlett', :country_id => 4, :role => 'BWL', :player_status => 'active')
  end

  def self.down
    williams = Player.find_by_display_name('Sean Williams')
    williams.player_status = "active"
    williams.save!

    ed = Player.find_by_display_name('Ed Rainsford')
    ed.player_status = "active"
    ed.save!

    sibanda = Player.find_by_display_name('Michael Hussey')
    sibanda.destroy

    sibanda = Player.find_by_display_name('Dirk Nannes')
    sibanda.destroy

    sibanda = Player.find_by_display_name('Chris Tremlett')
    sibanda.destroy
  end
end
