class BattingScoreCard < ActiveRecord::Base
  belongs_to :match
  belongs_to :player
  validates_associated :match
  validates_associated :player

  def country_one
    match.country_one
  end

  def country_two
    match.country_two
  end
end
