class User < ActiveRecord::Base
  has_many :authorizations
  has_many :user_game_datas

  cattr_reader :per_page
  @@per_page = 12

  def self.create_from_hash!(hash, profile_picture)
    create(:name => hash['user_info']['name'], :image => profile_picture)
  end
end
