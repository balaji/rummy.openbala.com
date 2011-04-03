class LoadIplMatches < ActiveRecord::Migration
  def self.up
    File.new("db/ipl_matches.txt", "r").each_line("\n") do |line|
      time, country_one_id, country_two_id, match_type, series, day_night, stadium_id = line.chomp.split("\t")
      Match.create!(:date => Time.parse(time), :series => series, :country_one_id => country_one_id, :country_two_id => country_two_id, :match_type => match_type, :stadium_id => stadium_id, :day_night => day_night.strip)
    end
  end

  def self.down
  end
end
