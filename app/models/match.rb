class Match < ActiveRecord::Base
  belongs_to :stadium
  belongs_to :country_one, :class_name => "Country"
  belongs_to :country_two, :class_name => "Country"
  validates_associated :stadium
  validates_associated :country_one
  validates_associated :country_two
  has_many :user_game_data
end
