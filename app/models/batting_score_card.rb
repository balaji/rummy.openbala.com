class BattingScoreCard < ActiveRecord::Base
  belongs_to :match
  belongs_to :player
  validates_associated :match
  validates_associated :player
  validates_presence_of :match, :player

  def validate
    errors.add_to_base "invalid data." if player.country.id != match.country_one.id and player.country.id != match.country_two.id
  end

  def self.country_one(match_id)
    BattingScoreCard.find(:all, :conditions => ['match_id = ? and player_id in (?)', match_id, Match.find(match_id).country_one.players])
  end

  def self.country_two(match_id)
    BattingScoreCard.find(:all, :conditions => ['match_id = ? and player_id in (?)', match_id, Match.find(match_id).country_two.players])
  end
end
