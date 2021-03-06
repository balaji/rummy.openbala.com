class User < ActiveRecord::Base
  has_many :authorizations
  has_many :user_game_datas
  has_many :current_forms

  cattr_reader :per_page
  @@per_page = 10

  def self.create_from_hash!(hash, profile_picture)
    create(:name => hash['user_info']['name'], :image => profile_picture)
  end
end
