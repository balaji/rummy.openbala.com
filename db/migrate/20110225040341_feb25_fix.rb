class Feb25Fix < ActiveRecord::Migration
  def self.up
    bang = Match.find(22)
    bang.date = bang.date.change({:hour => 14, :min => 0})
    bang.save!

    aus = Match.find(23)
    aus.date = aus.date.change({:hour => 9, :min => 30})
    aus.save!
  end

  def self.down
  end
end
