class MatchTotal < ActiveRecord::Base
  belongs_to :match
  belongs_to :country
  validates_associated :match
  validates_associated :country

  def validate
    errors.add_to_base "invalid data." if country.id != match.country_one.id and country.id != match.country_two.id
  end
end
