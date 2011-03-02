class BishooForBravo < ActiveRecord::Migration
  def self.up
    bravo = Player.find_by_display_name('Dwayne Bravo')
    bravo.player_status = 'retired'
    bravo.save!

    Player.create!(:country_id => 13, :short_name => 'D Bishoo', :display_name => 'Devendra Bishoo', :role => 'AR', :player_status => 'active')
  end

  def self.down
 bravo = Player.find_by_display_name('Dwayne Bravo')
    bravo.status = 'active'
    bravo.save!

    bishoo = Player.find_by_short_name('D Bishoo')
    bishoo.destroy
  end
end
