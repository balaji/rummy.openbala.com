class DateToDatetimeOfMatch < ActiveRecord::Migration
  def self.up
    change_column(:matches, :date, :datetime)
    File.new("db/time.txt", 'r').each_line("\n") do |row|
      columns = row.chomp.split("\t")
      time = columns[1].split(":")
      match = Match.find(columns[0])
      match.date = match.date.change({:hour => time[0], :min => time[1]})
      match.save!
    end
  end

  def self.down
    change_column(:matches, :date, :date)
  end
end
