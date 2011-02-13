class Match < ActiveRecord::Base
  belongs_to :stadium
  belongs_to :country_one, :class_name => "Country"
  belongs_to :country_two, :class_name => "Country"
  validates_associated :stadium
  validates_associated :country_one
  validates_associated :country_two
  has_many :user_game_datas
  has_many :batting_score_cards
  has_many :bowling_score_cards
  has_many :match_totals
  has_many :player_match_points
  validates_presence_of :stadium, :country_one, :country_two, :date

  def validate
    errors.add_to_base "invalid data." if country_one.id == country_two.id
  end
end
