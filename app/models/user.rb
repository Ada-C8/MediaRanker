class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes
  has_many :works
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true, inclusion: { in: ["github"] }

  def number_of_vote
    vote_num = 0
    votes.each do |vote|
      vote_num += 1
    end
    return vote_num
  end

  def self.from_auth_hash(provider, auth_hash)
    user = new
    user.provider = provider
    user.uid = auth_hash['uid']
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    user.username = auth_hash['info']['nickname']
    # user.save
    return user
  end
end
