class User < ApplicationRecord
  has_many :votes

  validates :name, presence: true
  # validate uniqueness

  # def voted_works
  #   upvoted = []
  #   votes.each do |vote|
  #     upvoted << vote.work
  #   end
  #   return upvoted #.sort_by{ |work| work.created_at }
  # end
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
