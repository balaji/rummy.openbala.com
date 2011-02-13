class AddStatusToMatches < ActiveRecord::Migration
  def self.up
    add_column(:matches, :status, :string)
    all = Match.all
    all.each do |m|
      m.status = 'active'
      m.save
    end
  end

  def self.down
    remove_column(:matches, :status)
  end
end
