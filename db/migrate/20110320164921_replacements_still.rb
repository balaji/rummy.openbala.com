class ReplacementsStill < ActiveRecord::Migration
    def self.up
        bennett = Player.find_by_display_name('Hamish Bennett')
        bennett.player_status = 'retired'
        bennett.save!

        shahzad = Player.find_by_display_name('Ajmal Shahzad')
        shahzad.player_status = 'retired'
        shahzad.save!

        Player.create!(:country_id => 9, :display_name => 'Daryl Tuffey', :short_name => 'DR Tuffey', :role => 'BWL', :player_status => 'active')
        Player.create!(:country_id => 4, :display_name => 'Jade Drenbach', :short_name => 'JW Drenbach', :role => 'BWL', :player_status => 'active')
    end

    def self.down
        jade = Player.find_by_display_name('Jade Drenbach')
        jade.destroy

        tuffey = Player.find_by_display_name('Daryl Tuffey')
        tuffey.destroy

        bennett = Player.find_by_display_name('Hamish Bennett')
        bennett.player_status = 'active'
        bennett.save!

        shahzad = Player.find_by_display_name('Ajmal Shahzad')
        shahzad.player_status = 'active'
        shahzad.save!
    end
end
