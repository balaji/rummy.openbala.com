class IplCountries < ActiveRecord::Migration
  def self.up
    Country.create!(:name => "Chennai Super Kings")
    Country.create!(:name => "Deccan Chargers")
    Country.create!(:name => "Delhi Daredevils")
    Country.create!(:name => "Kings XI Punjab")
    Country.create!(:name => "Kochi Tuskers Kerala")
    Country.create!(:name => "Kolkata Knight Riders")
    Country.create!(:name => "Mumbai Indians")
    Country.create!(:name => "Pune Warriors")
    Country.create!(:name => "Rajasthan Royals")
    Country.create!(:name => "Royal Challengers Bangalore")
  end

  def self.down
  end
end
