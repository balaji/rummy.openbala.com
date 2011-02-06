class Country < ActiveRecord::Base
  has_many :matches, :finder_sql => 'SELECT DISTINCT * FROM matches m WHERE m.country_one_id = #{id} or m.country_two_id = #{id}'
  has_many :players
end
