class AddBallsToBattingCards < ActiveRecord::Migration
  def self.up
    add_column(:batting_score_cards, :balls, :integer)
  end

  def self.down
    remove_column(:batting_score_cards, :balls)
  end
end
