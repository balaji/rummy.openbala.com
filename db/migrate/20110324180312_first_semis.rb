class FirstSemis < ActiveRecord::Migration
  def self.up
    semi_1 = Match.find(62)
    semi_1.country_one = Country.find_by_name('India')
    semi_1.country_two = Country.find_by_name('Pakistan')
    semi_1.save!

    yardy = Player.find_by_display_name('Michael Yardy')
    yardy.player_status = 'retired'
    yardy.save!

    Player.create!(:country_id => 4, :display_name => 'Adil Rashid', :player_status => 'active', :short_name => 'AU Rashid', :role => 'BWL')
  end

  def self.down
  end
end
