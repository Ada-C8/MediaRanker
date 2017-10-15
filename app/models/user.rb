class User < ApplicationRecord
  has_many :votes
  validates :name, presence: true, uniqueness: true

  def total_votes_for_user
    return votes.count
  end




end
