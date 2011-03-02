# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  require 'open-uri'
  def sortable(column, title = nil)
    sort_column = params[:sort] ? params[:sort] : column
    country = params[:country]? params[:country] : 'all'
    title ||= column.titleize
    css_class = column == sort_column ? "current #{params[:direction].to_s}_" : nil
    direction = column == sort_column && params[:direction].to_s == "desc" ? "asc" : "desc"
    link_to title, {:sort => column, :direction => direction, :country => country}, {:class => css_class}
  end

  def stats
    all_players = Player.all
    players = Array.new
    all_players.each do |player|
      individual = Hash.new
      overs = player.bowling_score_cards.overs
      runs = player.batting_score_cards.score
      balls = player.batting_score_cards.balls
      individual[:name] = player.display_name
      individual[:runs] = player.batting_score_cards.score
      individual[:fours] = player.batting_score_cards.fours
      individual[:sixes] = player.batting_score_cards.sixes
      individual[:balls] = player.batting_score_cards.balls
      individual[:strike_rate] = (balls > 0)? ((runs.to_f / balls.to_f) * 10000).round.to_f/100 : 0
      individual[:wickets] = player.bowling_score_cards.wickets
      individual[:overs] = overs
      individual[:extras] = player.bowling_score_cards.extras
      individual[:maidens] = player.bowling_score_cards.maidens
      individual[:country] = player.country.name
      individual[:matches] = player.batting_score_cards.matches
      individual[:conceded] = player.bowling_score_cards.runs
      overs = overs.floor + ((overs.modulo(1) * 100).round.to_f / 10) / 6.0
      individual[:economy_rate] = (overs > 0) ? ((player.bowling_score_cards.runs.to_f / overs.to_f) * 100).round.to_f / 100 : 0
      players.push(individual)
    end
    players
  end

  def noko_bats(match_id)
    batsmen = []
    doc = Nokogiri::HTML(open("http://www.espncricinfo.com/icc_cricket_worldcup2011/engine/current/match/#{match_id}.html?view=scorecard"))
    doc.xpath('//table[@id="inningsBat1"]/tr | //table[@id="inningsBat2"]/tr').collect do |row|
      detail = {}
      start_at = row.at_xpath('td[9]/text()').to_s == '' ? 5 : 6
      [[:player_name, 'td[@class="playerName"]/a/text()'],
       [:wicket_desc, 'td[@class="battingDismissal"]/text()'],
       [:score, 'td[@class="battingRuns"]/text()'],
       [:balls, "td[#{start_at}]/text()"],
       [:fours, "td[#{start_at + 1}]/text()"],
       [:sixes, "td[#{start_at + 2}]/text()"],
       [:strike_rate, "td[#{start_at + 3}]/text()"]].collect do |name, xpath|
         a = row.at_xpath(xpath).to_s.strip
         detail[name] = a if a.length > 0
       end
       batsmen.push(detail) if !detail.empty? and detail[:player_name]
    end

    doc.xpath('//table[@class="inningsTable"]/tr').collect do |row|
      if row.at_xpath('td[@class="inningsDetails"]/b/text()').to_s == 'Did not bat'
        count = 1
        begin
          batsmen.push({:player_name => row.at_xpath("td/span[#{count}]/a/text()").to_s})
          count += 1
        end while row.at_xpath("td/span[#{count}]/a/text()").to_s != "" 
      end
    end
    batsmen
  end

  def noko_bowls(match_id)
    bowlers = []
    doc = Nokogiri::HTML(open("http://www.espncricinfo.com/icc_cricket_worldcup2011/engine/current/match/#{match_id}.html?view=scorecard"))
    doc.xpath('//table[@id="inningsBowl1"]/tr | //table[@id="inningsBowl2"]/tr').collect do |row|
      detail = {}
      [[:player_name, 'td[@class="playerName"]/a/text()'],
       [:overs, 'td[3]/text()'],
       [:maidens, 'td[4]/text()'],
       [:runs, 'td[5]/text()'],
       [:wickets, 'td[6]/text()'],
       [:economy_rate, 'td[7]/text()'],
       [:extras, 'td[8]/text()']].collect do |name, path|
        a = row.at_xpath(path).to_s.strip
        detail[name] = a if a.length > 0
       end
      bowlers.push(detail) if !detail.empty? and detail[:player_name]
    end
    bowlers
  end

  def noko_totals(match_id)
    doc = Nokogiri::HTML(open("http://www.espncricinfo.com/icc_cricket_worldcup2011/engine/current/match/#{match_id}.html?view=scorecard"))
    [jee(doc, "inningsBat1"), jee(doc, "inningsBat2")]
  end

  private

  def jee(doc, id)
    detail = {}
    country_desc = doc.xpath("//table[@id='#{id}']/tr[@class='inningsHead']/td[2]/text()").to_s
    detail[:country] = /(.*) innings$/.match(country_desc)[1]
     
    doc.xpath("//table[@id='#{id}']/tr").collect do |row|
      if(row.at_xpath('td[@class="inningsDetails"]/b/text()').to_s == 'Total')
        overs = /^\(.* (.*) overs.*\)/.match(row.at_xpath("td[@class='battingDismissal']/text()").to_s)[1]
        detail[:balls] = (overs.to_f.floor * 6) + ((overs.to_f.modulo(1)*100).round.to_f/10).to_i
        detail[:runs] = row.at_xpath("td[@class='battingRuns']/b/text()").to_s
      end
    end
    detail
  end
end
