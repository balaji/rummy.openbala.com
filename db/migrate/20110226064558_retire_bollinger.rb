class RetireBollinger < ActiveRecord::Migration
  def self.up
    bollinger = Player.find_by_short_name('DE Bollinger')
    bollinger.player_status = 'retired'
    bollinger.save!
  end

  def self.down
    bollinger = Player.find_by_short_name('DE Bollinger')
    bollinger.player_status = 'active'
    bollinger.save!
  end
end
