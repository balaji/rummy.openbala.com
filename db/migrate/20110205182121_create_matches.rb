class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.string :match_type, :null => false
      t.references :stadium
      t.date :date, :null => false
      t.boolean :day_night, :null => false
      t.integer :country_one_id
      t.integer :country_two_id

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
