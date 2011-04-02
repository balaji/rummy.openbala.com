class LoadIplPlayers < ActiveRecord::Migration
  def self.up
    count = 0
    File.new('db/ipl_players.txt', 'r').each_line("\n") do |row|
      display_name, ipl_team_id = row.chomp.split("\t")
      pr = Player.find_by_display_name(display_name)
      if pr != nil
        count = count + 1
        pr.ipl_country_id = ipl_team_id
        pr.save!
      end
    end
  end

  def self.down
    Player.find(:all, :conditions => ['ipl_country_id != ?', nil]).each do |p|
      p.ipl_country_id = nil
      p.save!
    end
  end
end
