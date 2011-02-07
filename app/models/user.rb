class User < ActiveRecord::Base
  has_many :authorizations
  has_many :user_game_data

  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end
end
