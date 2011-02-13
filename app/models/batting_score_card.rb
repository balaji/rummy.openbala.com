class BattingScoreCard < ActiveRecord::Base
  belongs_to :match
  belongs_to :player
  validates_associated :match
  validates_associated :player
  validates_presence_of :match, :player

  def validate
    errors.add_to_base "invalid data." if player.country.id != match.country_one.id and player.country.id != match.country_two.id
  end

  def country_one
    match.country_one
  end

  def country_two
    match.country_two
  end
end
