class Player < ActiveRecord::Base
  belongs_to :country
  validates_associated :country
  validates_presence_of :display_name
  validates_presence_of :short_name
  validates_presence_of :role
end
