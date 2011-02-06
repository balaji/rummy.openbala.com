class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string :display_name
      t.string :short_name
      t.string :role
      t.integer :points, t.default => 0
      t.references :country

      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
