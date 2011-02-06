Country.delete_all
Player.delete_all
Stadium.delete_all
Match.delete_all

puts "Truncate complete."

File.new("db/countries.txt", 'r').each_line("\n") do |str|
  Country.create!(:name => str) 
end

puts "#{Country.all.count} countries created."

File.new("db/players.txt", 'r').each_line("\n") do |row|
  country_id, role, short_name, display_name = row.chomp.split("\t")
  Player.create!(:display_name => display_name, :short_name => short_name, :role => role, :country_id => country_id)
end

puts "#{Player.all.count} players created."

File.new("db/stadia.txt", 'r').each_line("\n") do |s|
  city, name = s.chomp.split("|")
  Stadium.create!(:name => name, :city => city)
end

puts "#{Stadium.all.count} stadia created."

File.new("db/matches.txt", 'r').each_line("\n") do |m|
  date, country_one_id, country_two_id, match_type, stadium_id, day_night = m.chomp.split("\t")
  Match.create!(:date => Date.parse(date), :country_one_id => country_one_id, :country_two_id => country_two_id, :match_type => match_type, :stadium_id => stadium_id, :day_night => day_night)
end

puts "#{Match.all.count} matches created."
