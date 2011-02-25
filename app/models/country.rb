class Country < ActiveRecord::Base
  has_many :matches, :finder_sql => 'SELECT DISTINCT * FROM matches m WHERE m.country_one_id = #{id} or m.country_two_id = #{id}'
  has_many :players
  validates_presence_of :name

  def players
    Player.find(:all, :conditions => ['country_id = ? and player_status = ?', id, 'active'])
  end
end
