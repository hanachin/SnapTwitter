class User < ActiveRecord::Base
  attr_accessible :name, :screen_name, :uid, :token
  has_many :tweets

  def self.find_or_create_from_auth_hash(auth_hash)
    User.where(uid: auth_hash.uid).first_or_create(name: auth_hash.info[:name], token: auth_hash.credentials[:token])
  end
end
