class User < ApplicationRecord
  has_many :votes, dependent: :destroy

  def voted?(work)
    self.votes.each do |vote|
      if vote.work_id == work.id
        return true
      end
    end
    return false
  end
end
