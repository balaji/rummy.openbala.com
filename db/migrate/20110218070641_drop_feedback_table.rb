class DropFeedbackTable < ActiveRecord::Migration
  def self.up
    drop_table(:feedbacks)
  end

  def self.down
    create_table :feedbacks do |t|
      t.references :user
      t.text :content

      t.timestamps
    end
  end
end
