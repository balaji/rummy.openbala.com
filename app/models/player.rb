class Player < ActiveRecord::Base
  belongs_to :country
  validates_associated :country
  validates_presence_of :display_name
  validates_presence_of :short_name
  validates_presence_of :role
  has_many :batting_score_cards
  has_many :bowling_score_cards
  has_many :player_match_points

  def self.played_match_country_one(match_id)
    Player.find_by_sql(["select * from players p where p.id in (select player_id from batting_score_cards b where b.match_id = ?) and p.country_id = (select m.country_one_id from matches m where m.id = ?)", match_id, match_id])
  end

  def self.played_match_country_two(match_id)
    Player.find_by_sql(["select * from players p where p.id in (select player_id from batting_score_cards b where b.match_id = ?) and p.country_id = (select m.country_two_id from matches m where m.id = ?)", match_id, match_id])
  end
end
