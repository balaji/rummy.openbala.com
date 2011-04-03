class Stadium < ActiveRecord::Base
  has_many :matches
  validates_presence_of :name, :city

  def self.ipl_stadia
    Stadium.find_by_sql(['select distinct s.id, s.name, s.city from stadia s, matches m where m.id > 63 and m.stadium_id = s.id'])
  end
end
