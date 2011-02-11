class CreateMatchTotals < ActiveRecord::Migration
  def self.up
    create_table :match_totals do |t|
      t.references :match
      t.references :country
      t.integer :score
      t.integer :balls

      t.timestamps
    end
  end

  def self.down
    drop_table :match_totals
  end
end
