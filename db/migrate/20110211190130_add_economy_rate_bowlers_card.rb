class AddEconomyRateBowlersCard < ActiveRecord::Migration
  def self.up
    add_column(:bowling_score_cards, :economy_rate, :float)
  end

  def self.down
    remove_column(:bowling_score_cards, :economy_rate)
  end
end
