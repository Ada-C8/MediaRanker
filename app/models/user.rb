class User < ApplicationRecord
  has_many :votes

  def upvote(work_id)
    work = Work.find(work_id)
    if Vote.where(work: work, user: self).count > 0
      return false, 'Cannot upvote more than once!'
    end
    vote = Vote.new(work: work, user: self)
    vote.save
  end
end
