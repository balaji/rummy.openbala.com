class Stadium < ActiveRecord::Base
  has_many :matches
  validates_presence_of :name, :city
end
