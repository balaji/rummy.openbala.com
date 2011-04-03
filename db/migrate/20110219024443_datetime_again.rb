class DatetimeAgain < ActiveRecord::Migration
  def self.up
    File.new("#{RAILS_ROOT}/db/time.txt", 'r').each_line("\n") do |row|
      columns = row.chomp.split("\t")
      time = columns[1].split(":")
      match = Match.find(columns[0])
      match.date = match.date.change({:hour => time[0], :min => time[1]})
      match.save!
    end
  end

  def self.down
  end
end
