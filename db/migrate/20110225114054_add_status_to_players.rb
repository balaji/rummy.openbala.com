class AddStatusToPlayers < ActiveRecord::Migration
  def self.up
    add_column(:players, :player_status, :string)

    Player.all.each do |player|
      player.player_status = 'active'
      player.save!
    end

    barath = Player.find_by_short_name('AB Barath')
    barath.player_status = 'retired'
    barath.save!

    baugh = Player.find_by_short_name('CS Baugh')
    baugh.player_status = 'retired'
    baugh.save!

  end

  def self.down
    remove_column(:players, :player_status)
  end
end
