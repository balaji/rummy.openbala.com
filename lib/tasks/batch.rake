require "#{RAILS_ROOT}/app/helpers/application_helper"
include ApplicationHelper

namespace :rummy do
  task :load_noko_bats, :match_id, :my_match_id, :needs => :environment do |t, args|
    noko_bats(args[:match_id]).each do |player|
      p player
      sc = BattingScoreCard.new
      sc.player_id = Player.find_by_short_name(player[:player_name]).id
      sc.match_id = args[:my_match_id]
      sc.wicket_desc = player[:wicket_desc].gsub("†", "").gsub("*", "") if player[:wicket_desc]
      sc.score = player[:score]
      sc.fours = player[:fours]
      sc.balls = player[:balls]
      sc.sixes = player[:sixes]
      sc.strike_rate = player[:strike_rate]
      sc.save!
    end
  end

  task :load_noko_balls, :match_id, :my_match_id, :needs => :environment do |t, args|
    noko_bowls(args[:match_id]).each do |player|
      p player
      sc = BowlingScoreCard.new
      sc.match_id = args[:my_match_id]
      sc.player_id = Player.find_by_short_name(player[:player_name]).id
      sc.overs = player[:overs]
      sc.maidens = player[:maidens]
      sc.runs = player[:runs]
      sc.wickets = player[:wickets].strip
      sc.economy_rate = player[:economy_rate]
      if player[:extras] and not player[:extras].strip.empty?
        extras = 0
        matches = /.*\((.*)\).*/.match(player[:extras])[1].split(',')
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
    end
  end

  task :load_noko_totals, :match_id, :my_match_id, :needs => :environment do |t, args|
    noko_totals(args[:match_id]).each do |total|
      p total
      mt = MatchTotal.new
      mt.match_id = args[:my_match_id]
      mt.country_id = Country.find_by_name(total[:country].strip).id
      mt.score = total[:runs]
      mt.balls = total[:balls]
      mt.save!
    end
  end

  task :calculate, :match_id, :needs => :environment do |t, args|
    country_one_id = Match.find(args[:match_id]).country_one.id
    country_one_total = MatchTotal.find(:all, :conditions => ["match_id = ? and country_id = ?", args[:match_id], country_one_id])
    country_two_id = Match.find(args[:match_id]).country_two.id
    country_two_total = MatchTotal.find(:all, :conditions => ["match_id = ? and country_id = ?", args[:match_id], country_two_id])
    c1_graph = country_one_total[0].score.to_f / country_one_total[0].balls.to_f if country_one_total[0].balls > 0
    c2_graph = country_two_total[0].score.to_f / country_two_total[0].balls.to_f if country_two_total[0].balls > 0
    country_one_run_rate = ((c1_graph.to_f * 6) * 100).round / 100.0
    country_two_run_rate = ((c2_graph.to_f * 6) * 100).round / 100.0
    country_one_strike_rate = ((c1_graph.to_f * 100) * 100).round / 100.0
    country_two_strike_rate = ((c2_graph.to_f * 100) * 100).round / 100.0

    player_points = Hash.new
    match_players = Player.played_match(args[:match_id])

    bsc = BattingScoreCard.find(:all, :conditions => ["match_id = ?", args[:match_id]])
    bsc.each do |sc|
      strike_rate = (20 if sc.strike_rate.to_i >= 100 and sc.score.to_i >= 25)
      points = sc.fours.to_i * 2 + sc.sixes.to_i * 3 + ((sc.score.to_f / 5) * 4.0).round + (strike_rate.to_i)
      sr_delta = sc.strike_rate.to_i - ((sc.player.country_id == country_one_id) ? country_one_strike_rate : country_two_strike_rate)
      delta = ((sr_delta * 1 / 4).round if sr_delta.to_i > 0 and sc.score.to_i >= 25) if sr_delta != sc.strike_rate.to_i
      points = points + (delta.to_i)

      players = []
      wicket_desc = sc.wicket_desc
       if ((match = /.*c sub \((.*)\).*/.match(wicket_desc)))
        players = match[1].to_a
      elsif ((match = /.*c & b (.*).*/.match(wicket_desc)))
        players = match[1].to_a
      elsif ((match = /.*c (.*) b.*/.match(wicket_desc)))
        players = match[1].to_a
      elsif ((match = /.*run out \((.*)\).*/.match(wicket_desc)))
        players = match[1].split('/')
      elsif ((match = /.*st (.*) b .*/.match(wicket_desc)))
        players = match[1].to_a
      end

       if players
         players.each do |p|
           match_players.each do |player|
             if player.short_name =~ /#{p}$/
               player_points[player.id] = player_points[player.id].to_i + 20
               break
             end
           end
         end
       end

      player_points[sc.player_id] = player_points[sc.player_id].to_i + points
    end

    p "batting points done"
    bo_sc = BowlingScoreCard.find(:all, :conditions => ["match_id = ?", args[:match_id]])
    bo_sc.each do |sc|
      economy_rate = 20 if sc.economy_rate.to_f <= 4.5 and sc.overs.to_i >= 3
      er_delta = ((sc.player.country_id == country_one_id) ? country_two_run_rate : country_one_run_rate) - sc.economy_rate
      delta = (er_delta / 0.3).round * 4 if er_delta > 0 and sc.overs.to_i >= 3 if er_delta != (-1 * sc.economy_rate)
      points = sc.wickets * 20 + sc.maidens * 8 + economy_rate.to_i + delta.to_i
      player_points[sc.player_id] = player_points[sc.player_id].to_i + points
    end

    p "bowling points done"
    player_points.each do |key, value|
      point = PlayerMatchPoint.new(:match_id => args[:match_id], :player_id => key, :points => value)
      point.save!
      p "#{key} --> #{value}"
    end
  end

  task :revoke, :match_id, :needs => :environment do |t, args|
    player_match_points = PlayerMatchPoint.find(:all, :conditions => ['match_id = ?', args[:match_id]])

    player_points = Hash.new
    player_match_points.each do |player_match_point|
      player_points[player_match_point.player_id.to_s] = player_match_point.points
    end

    user_data = UserGameData.find(:all, :conditions => ['match_id = ?', args[:match_id]])
    user_data.each do |user_datum|
      orders = user_datum.player_order.split(',')

      points = (player_points[orders[0]].to_i * 5) + (player_points[orders[1]].to_i * 4) + (player_points[orders[2]].to_i * 3) + (player_points[orders[3]].to_i * 2) + (player_points[orders[4]].to_i)
      p points
      user_datum.points = points
      user = User.find(user_datum.user_id)
      if (user.total_points > 0)
        user.total_points = user.total_points - points
      else
        user.total_points = 0
      end
      user_datum.save!
      user.save!
      m = Match.find(args[:match_id])
      m.status = 'active'
      m.save!
    end
  end

  task :update, :match_id, :needs => :environment do |t, args|
    player_match_points = PlayerMatchPoint.find(:all, :conditions => ['match_id = ?', args[:match_id]])

    player_points = Hash.new
    player_match_points.each do |player_match_point|
      player_points[player_match_point.player_id.to_s] = player_match_point.points
    end

    user_data = UserGameData.find(:all, :conditions => ['match_id = ?', args[:match_id]])
    user_data.each do |user_datum|
      orders = user_datum.player_order.split(',')

      points = (player_points[orders[0]].to_i * 5) + (player_points[orders[1]].to_i * 4) + (player_points[orders[2]].to_i * 3) + (player_points[orders[3]].to_i * 2) + (player_points[orders[4]].to_i)
      p points
      user_datum.points = points
      user = User.find(user_datum.user_id)
      if (user.total_points > 0)
        user.total_points = user.total_points + points
      else
        user.total_points = points
      end
      user_datum.save!
      user.save!
      m = Match.find(args[:match_id])
      m.status = 'finished'
      m.save!
    end
  end

  task :boast, :match_id, :needs => :environment do |t, args|
    match = Match.find(args[:match_id])
    country_one = match.country_one.name
    country_two = match.country_two.name
    graph = Koala::Facebook::GraphAPI.new(Koala::Facebook::OAuth.new(FACEBOOK_APP_ID, FACEBOOK_APP_SECRET, nil).get_app_access_token)
    api = Koala::Facebook::RestAPI.new(Koala::Facebook::OAuth.new(FACEBOOK_APP_ID, FACEBOOK_APP_SECRET, nil).get_app_access_token)
    user_data = UserGameData.find(:all, :conditions => ['match_id = ?', args[:match_id]], :order => "points DESC")
    user_data.length.times do |i|
      auth = Authorization.find_by_user_id(user_data[i].user_id)
      if auth.provider == 'facebook'
        uid = auth.uid
        if /1$/.match("#{api.fql_query('SELECT publish_stream FROM permissions WHERE uid = ' + uid)}")
          begin
            graph.put_wall_post("You're ranked #{i + 1} in the Rummy game for the match between #{country_one} and #{country_two}",
                                {"name" => "Full Results",
                                 "caption" => "http://rummy.opebala.com",
                                 "description" => "A Game site for ICC World Cup 2011",
                                 "link" => "http://rummy.openbala.com/profile",
                                 "picture" => "http://rummy.openbala.com/images/logo.jpg"}, uid)
          rescue 
            p "#{i + 1} rank"
          end
        end
      end
    end
#    Rake.application.invoke_task("rummy:reload_cache")
  end

  task :invalidate_session, :needs => :environment do |t, args|
    reset_session
  end

  task :current_form_revoke, :match_id, :needs => :environment do |t, args|
    CurrentForm.find_all_by_match_id(args[:match_id]).each do |form|
      CurrentForm.destroy(form.id)
      puts "destroying form: #{form.id}"
    end
  end

  task :current_form, :match_id, :needs => :environment do |t, args|
      form = Hash.new
      UserGameData.find(:all, :conditions => ['match_id in (?)', Match.find(:all, :select => 'id', :conditions => ['status = ?', 'finished'], :order => 'id desc', :limit => 3)]).each do |game_data|
        if form[game_data.user]
          form[game_data.user] += game_data.points
        else
          form[game_data.user] = game_data.points
        end
      end
      form_sorted = form.sort_by{|user, points| -points}
      form_sorted.length.times do |i|
        CurrentForm.create!(:user => form_sorted[i][0], :points => form_sorted[i][1], :match => Match.find(args[:match_id]), :rank => i + 1)
      end
  end

  task :revert, :my_match_id, :needs => :environment do |t, args|
    Rake.application.invoke_task("rummy:revoke[#{args[:my_match_id]}]")
    Rake.application.invoke_task("rummy:current_form_revoke[#{args[:my_match_id]}]")
    BattingScoreCard.find_all_by_match_id(args[:my_match_id]).each do |card|
      BattingScoreCard.destroy(card.id)
      puts "destroying batting #{card.id}"
    end
    BowlingScoreCard.find_all_by_match_id(args[:my_match_id]).each do |card|
      BowlingScoreCard.destroy(card.id)
      puts "destroying bowling #{card.id}"
    end
    PlayerMatchPoint.find_all_by_match_id(args[:my_match_id]).each do |match|
      PlayerMatchPoint.destroy(match.id)
      puts "destroying player point #{match.id}"
    end
    MatchTotal.find_all_by_match_id(args[:my_match_id]).each do |total|
      MatchTotal.destroy(total.id)
      puts "destroying total #{total.id}"
    end
  end

  task :old_monty, :my_match_id, :needs => :environment do |t, args|
    Rake.application.invoke_task("rummy:load_bats[#{args[:my_match_id]}]")
    Rake.application.invoke_task("rummy:load_balls[#{args[:my_match_id]}]")
    Rake.application.invoke_task("rummy:load_totals[#{args[:my_match_id]}]")
    Rake.application.invoke_task("rummy:calculate[#{args[:my_match_id]}]")
    Rake.application.invoke_task("rummy:update[#{args[:my_match_id]}]")
    Rake.application.invoke_task("rummy:current_form[#{args[:my_match_id]}]")
  end

  task :monty, :match_id, :my_match_id, :needs => :environment do |t, args|
    Rake.application.invoke_task("rummy:load_noko_bats[#{args[:match_id]},#{args[:my_match_id]}]")
    Rake.application.invoke_task("rummy:load_noko_balls[#{args[:match_id]},#{args[:my_match_id]}]")
    Rake.application.invoke_task("rummy:load_noko_totals[#{args[:match_id]},#{args[:my_match_id]}]")
    Rake.application.invoke_task("rummy:calculate[#{args[:my_match_id]}]")
    Rake.application.invoke_task("rummy:update[#{args[:my_match_id]}]")
    Rake.application.invoke_task("rummy:current_form[#{args[:my_match_id]}]")
  end

  task :reload_cache, :needs => :environment do |t, args|
    Rails.cache.delete("players_raw_data")
    Rails.cache.fetch("players_raw_data") do
      stats
   end
  end

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
    puts "bowlers started...."
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
    puts "bats started...."
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
    puts "bats done....."
  end
end

