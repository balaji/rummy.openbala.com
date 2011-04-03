class AddDevonThomas < ActiveRecord::Migration
  def self.up
    Player.create!(:country_id => 13, :short_name => 'DC Thomas', :display_name =>    'Devon Thomas', :role => 'WK')
    Player.create!(:country_id => 13, :short_name => 'KA Edwards', :display_name => 'Kirk Edwards', :role => 'BWL')
  end

  def self.down
    thomas = Player.find_by_short_name('DC Thomas')
    thomas.destroy

    edwards = Player.find_by_short_name('KA Edwards')
    edwards.destroy
  end
end
