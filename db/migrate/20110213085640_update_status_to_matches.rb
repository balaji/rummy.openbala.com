class UpdateStatusToMatches < ActiveRecord::Migration
  def self.up
    Match.all.each do |m|
      m.match_status = 'active'
      m.save!
    end
  end

  def self.down
  end
end
