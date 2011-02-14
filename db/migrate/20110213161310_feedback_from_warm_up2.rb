class FeedbackFromWarmUp2 < ActiveRecord::Migration
  def self.up
    h_singh = Player.find_by_short_name('H Singh')
    h_singh.short_name = 'Harbhajan Singh'
    h_singh.save!

    y_singh = Player.find_by_short_name('Y Singh')
    y_singh.short_name = 'Yuvraj Singh'
    y_singh.save!

    kumar = Player.find_by_short_name('P Kumar')
    kumar.destroy

    hussey = Player.find_by_short_name('MEK Hussey')
    hussey.destroy

    hauritz = Player.find_by_short_name('NM Hauritz')
    hauritz.destroy

    Player.create!(:country_id => 5, :short_name => 'S Sreesanth', :display_name => 'Shanthakumaran Sreesanth', :role => 'BWL')
    Player.create!(:country_id => 1, :short_name => 'JJ Krejza', :display_name => 'Jason Krejza', :role => 'BWL')
    Player.create!(:country_id => 1, :short_name => 'CJ Ferguson', :display_name => 'Callum Ferguson', :role => 'BAT')

  end

  def self.down
    h_singh = Player.find_by_short_name('Harbhajan Singh')
    h_singh.short_name = 'H Singh'
    h_singh.save!

    y_singh = Player.find_by_short_name('Yuvraj Singh')
    y_singh.short_name = 'Y Singh'
    y_singh.save!

    sreesanth = Player.find_by_short_name('S Sreesanth')
    sreesanth.destroy

    krejza = Player.find_by_short_name('JJ Krejza')
    krejza.destroy

    krejza = Player.find_by_short_name('CJ Ferguson')
    krejza.destroy

    Player.create!(:country_id => 5, :short_name => 'P Kumar', :display_name => 'Praveen Kumar', :role => 'BWL')
    Player.create!(:country_id => 1, :short_name => 'MEK Hussey', :display_name => 'Michael Hussey', :role => 'BAT')
  end
end
