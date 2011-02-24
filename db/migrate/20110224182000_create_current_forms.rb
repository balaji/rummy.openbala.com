class CreateCurrentForms < ActiveRecord::Migration
  def self.up
    create_table :current_forms do |t|
      t.references :match
      t.references :user
      t.integer :points
      t.integer :rank

      t.timestamps
    end
  end

  def self.down
    drop_table :current_forms
  end
end
