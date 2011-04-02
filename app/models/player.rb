class Player < ActiveRecord::Base
  belongs_to :country
  validates_associated :country
  belongs_to :ipl_country, :class_name => "Country"
  validates_associated :ipl_country
  validates_presence_of :display_name
  validates_presence_of :short_name
  validates_presence_of :role
  has_many :batting_score_cards do
    def score
      total_score = 0
      find(:all, :conditions => ['match_id > 14']).each {|match| total_score += match.score.to_i}
      total_score
    end

    def fours
      total_fours = 0
      find(:all, :conditions => ['match_id > 14']).each {|match| total_fours += match.fours.to_i}
      total_fours
    end

    def sixes
      total_sixes = 0
      find(:all, :conditions => ['match_id > 14']).each {|match| total_sixes += match.sixes.to_i}
      total_sixes
    end

    def balls
      total_balls = 0
      find(:all, :conditions => ['match_id > 14']).each {|match| total_balls += match.balls.to_i}
      total_balls
    end

    def matches
      find(:all, :conditions => ['match_id > 14']).count
    end

    def fifties
      total_fifties = 0
      find(:all, :conditions => ['match_id > 14']).each {|match| total_fifties+= 1 if match.score and match.score >= 50 and match.score < 100}
      total_fifties
    end

    def hundreds
      total_hundreds = 0
      find(:all, :conditions => ['match_id > 14']).each {|match| total_hundreds += 1 if match.score and match.score >= 100}
      total_hundreds
    end
  end

  has_many :bowling_score_cards do
    def wickets
      total_wickets = 0
      find(:all, :conditions => ['match_id > 14']).each {|match| total_wickets += match.wickets.to_i}
      total_wickets
    end

    def fives
      total_wickets = 0
      find(:all, :conditions => ['match_id > 14']).each {|match| total_wickets += 1 if match.wickets and match.wickets >= 5}
      total_wickets
    end

    def maidens
      total_maidens = 0
      find(:all, :conditions => ['match_id > 14']).each {|match| total_maidens += match.maidens.to_i}
      total_maidens
    end

    def overs
      total_overs = 0.0
      find(:all, :conditions => ['match_id > 14']).each {|match| total_overs += match.overs.to_f}
      (total_overs.floor == total_overs) ? total_overs.floor : total_overs
    end

    def extras
      total_extras = 0
      find(:all, :conditions => ['match_id > 14']).each {|match| total_extras += match.extras.to_i}
      total_extras
    end

    def runs
      total_runs = 0
      find(:all, :conditions => ['match_id > 14']).each {|match| total_runs += match.runs.to_i}
      total_runs
    end
  end

  has_many :player_match_points do 
    def total
      total_points = 0
      find(:all, :conditions => ['match_id > 14']).each {|match| total_points += match.points} 
      total_points
    end
  end

  def self.played_match(match_id)
    Player.find_by_sql(["select * from players p where p.id in (select player_id from batting_score_cards b where b.match_id = ?) and (p.country_id = (select m.country_one_id from matches m where m.id = ?) or p.country_id = (select m.country_two_id from matches m where m.id = ?))", match_id, match_id, match_id])
  end
end
