class BowlingScoreCard < ActiveRecord::Base
  belongs_to :match
  belongs_to :player
  validates_associated :match
  validates_associated :player
  validates_presence_of :match, :player, :overs

  def validate
    errors.add_to_base "invalid data." if player.country.id != match.country_one.id and player.country.id != match.country_two.id
  end
end
