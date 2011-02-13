class PlayerMatchPoint < ActiveRecord::Base
  belongs_to :match
  belongs_to :player

  def validate
    errors.add_to_base "invalid data." if player.country.id != match.country_one.id and player.country.id != match.country_two.id
  end
end
