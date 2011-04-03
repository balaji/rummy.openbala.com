class MorganForPietersen < ActiveRecord::Migration
  def self.up
    kp = Player.find_by_short_name('KP Pietersen')
    kp.player_status = 'retired'
    kp.save!

    Player.create(:country_id => 4, :display_name => 'Eoin Morgan', :role => 'BAT', :player_status => 'active', :short_name => 'EJG Morgan')
  end

  def self.down
    kp = Player.find_by_short_name('KP Pietersen')
    kp.player_status = 'active'
    kp.save!

    morgan = Player.find_by_short_name('EJG Morgan')
    morgan.destroy
  end
end
