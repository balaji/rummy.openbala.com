class QuarterFinals < ActiveRecord::Migration
  def self.up
      q1 = Match.find(57)
      q1.country_one = Country.find(10)
      q1.country_two = Country.find(13)
      q1.save!

      q2 = Match.find(58)
      q2.country_one = Country.find(1)
      q2.country_two = Country.find(5)
      q2.stadium = Stadium.find(1)
      q2.save!

      q3 = Match.find(59)
      q3.country_one = Country.find(9)
      q3.country_two = Country.find(11)
      q3.save!

      q4 = Match.find(60)
      q4.country_one = Country.find(4)
      q4.country_two = Country.find(12)
      q4.stadium = Stadium.find(5)
      q4.save!
  end

  def self.down
  end
end
