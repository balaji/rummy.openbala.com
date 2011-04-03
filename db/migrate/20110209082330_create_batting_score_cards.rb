class CreateBattingScoreCards < ActiveRecord::Migration
  def self.up
    create_table :batting_score_cards do |t|
      t.references :match
      t.references :player
      t.string :wicket_desc
      t.integer :score
      t.integer :fours
      t.integer :sixes
      t.float :strike_rate

      t.timestamps
    end
  end

  def self.down
    drop_table :batting_score_cards
  end
end
