class FeedbackFromWarmUp4 < ActiveRecord::Migration
  def self.up
    Player.create!(:display_name => 'Terrence Duffin', :short_name => 'T Duffin', :country_id => 14, :role => 'BAT')

    Player.create!(:display_name => 'Ravi Bopara', :short_name => 'RS Bopara', :country_id => 4, :role => 'BAT')

    mawoyo = Player.find_by_short_name('TMK Mawoyo')
    mawoyo.destroy

    morgan = Player.find_by_short_name('EJG Morgan')
    morgan.destroy
  end

  def self.down
    Player.create!(:display_name => 'Tino Mawoyo', :short_name => 'TMK Mawoyo', :country_id => 14, :role => 'BAT')

    Player.create!(:display_name => 'Eoin Morgan', :short_name => 'EJG Morgan', :country_id => 14, :role => 'BAT')

    duffin = Player.find_by_short_name('T Duffin')
    duffin.destroy

    bopara = Player.find_by_short_name('RS Bopara')
    bopara.destroy
  end
end
