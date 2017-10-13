class User < ApplicationRecord
  has_many :votes, dependent: :destroy

  #
  # def vote_count
  #   sum = 0
  #   votes.each do
  #     sum +=1
  #   end
  #   return sum
  # end

  def voted?(work)
    self.votes.each do |vote|
      if vote.work_id == work.id
        return true
      end
    end
    return false
  end
end
