class AddStatusToMatch < ActiveRecord::Migration
  def self.up
    add_column(:matches, :status, :string, {:default => 'active'})
    Match.find(:all).sort_by { |m| m.date }.each do |m|
      if (m.date < Time.now.in_time_zone('Chennai') - 8.hours)
        m.status = 'finished'
      else
        m.status = 'active'
      end
      m.save!
    end
  end

  def self.down
    remove_column(:matches, :status)
  end
end
