namespace :rummy do
  task :load_totals, :match_id, :needs => :environment do |t, args|
    File.new("#{RAILS_ROOT}/db/data/totals#{args[:match_id]}.txt", 'r').each_line("\n") do |row|
      columns = row.split("\t")
      p columns
      mt = MatchTotal.new
      mt.match_id = args[:match_id]
      mt.country_id = Country.find_by_name(columns[0].strip).id
      mt.score = columns[1]
      mt.balls = columns[2].strip
      mt.save!
    end
  end

  task :load_balls, :match_id, :needs => :environment do |t, args|
    File.new("#{RAILS_ROOT}/db/data/bowlers#{args[:match_id]}.txt", 'r').each_line("\n") do |row|
      columns = row.split("\t")
      sc = BowlingScoreCard.new
      sc.match_id = args[:match_id]
      sc.player_id = Player.find_by_short_name(columns[0]).id
      sc.overs = columns[1]
      sc.maidens = columns[2]
      sc.runs = columns[3]
      sc.wickets = columns[4].strip
      sc.economy_rate = columns[5]
      if columns[6] and not columns[6].strip.empty?
        extras = 0
        matches = /.*\((.*)\).*/.match(columns[6])[1].split(',')
        matches.each do |m|
          if ((x = /(.*)w.*/.match(m)))
            extras += x[1].to_i
          elsif ((x = /(.*)nb.*/.match(m)))
            extras += x[1].to_i
          end
        end
        sc.extras = extras
      end
      sc.save!
      p columns
    end
  end

  task :load_bats, :match_id, :needs => :environment do |t, args|
    File.new("#{RAILS_ROOT}/db/data/batsmen#{args[:match_id]}.txt", 'r').each_line("\n") do |row|
      sc = BattingScoreCard.new
      columns = row.split("\t")
      p columns
      sc.player_id = Player.find_by_short_name(columns[0].strip).id
      sc.match_id = args[:match_id]
      sc.wicket_desc = columns[1].to_s
      sc.score = columns[2]
      sc.fours = columns[5]
      sc.balls = columns[4]
      sc.sixes = columns[6]
      sc.strike_rate = columns[7].strip if columns[7]
      sc.save!
    end
  end
end
