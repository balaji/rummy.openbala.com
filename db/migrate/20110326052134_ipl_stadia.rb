class IplStadia < ActiveRecord::Migration
  def self.up
    Stadium.create!(:city => "Indore", :name => "Holkar Cricket Stadium")
    Stadium.create!(:city => "Dharamsala", :name => "Himachal Pradesh Cricket Association Stadium")
    Stadium.create!(:city => "Hyderabad", :name => "Rajiv Gandhi International Stadium")
    Stadium.create!(:city => "Navi-Mumbai", :name => "Dr DY Patil Sports Academy")
    Stadium.create!(:city => "Kochi", :name => "Nehru Stadium")
    Stadium.create!(:city => "Jaipur", :name => "Sawai Mansingh Stadium")
  end

  def self.down
  end
end
