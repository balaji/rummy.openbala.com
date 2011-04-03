class Authorization < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  cattr_reader :per_page
  @@per_page = 10

  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, profile_picture, user = nil)
    user ||= User.create_from_hash!(hash, profile_picture)
    Authorization.create(:user => user, :uid => hash['uid'], :provider => hash['provider'])
  end
end
