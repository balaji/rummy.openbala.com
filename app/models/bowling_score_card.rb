class BowlingScoreCard < ActiveRecord::Base
  belongs_to :match
  belongs_to :player
  validates_associated :match
  validates_associated :player
end
