class EditSeriesForWc < ActiveRecord::Migration
  def self.up
    Match.find(:all, :conditions => ['id < ?', 64]) .each do |m| 
      m.series = 'cwc2011'
      m.save!
    end
  end

  def self.down
  end
end
