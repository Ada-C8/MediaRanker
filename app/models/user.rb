class User < ApplicationRecord
  has_many :votes

  validates :name, presence: true
  # validate uniqueness

  def voted_works
    upvoted = []
    votes.each do |vote|
      upvoted << vote.work
    end
    return upvoted #.sort_by{ |work| work.created_at }
  end
end
