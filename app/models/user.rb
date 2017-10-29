class User < ApplicationRecord
  validates :name, :email, presence: true
  validates_format_of :email, :with =>  /\A\S+@.+\.\S+\z/
  validates :email, uniqueness: true
  has_many :votes
  validates :oauth_provider, presence: true
  validates :oauth_uid, presence: true, uniqueness: true

  def self.by_auth_hash(auth_hash)
    user = User.new

    user.oauth_provider = auth_hash['provider']
    user.oauth_uid = auth_hash['uid']
    user.email = auth_hash['info']['email']
    user.name = auth_hash['info']['nickname']

    user
  end
end
