# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
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
end
