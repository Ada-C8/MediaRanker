class User < ApplicationRecord
  has_many :votes, dependent: :destroy


  def vote_count
    sum = 0
    votes.each do
      sum +=1
    end
    return sum
  end
end
