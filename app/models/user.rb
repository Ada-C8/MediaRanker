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

  
end
