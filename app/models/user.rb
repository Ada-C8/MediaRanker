class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes
  validates :username, presence: true, uniqueness: true

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
    return user
  end
end
