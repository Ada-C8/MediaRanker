class User < ApplicationRecord
  has_many :votes

  validates :name, presence: true

  def vote(work)
    if work.id
      vote = Vote.new(work_id: work.id, user_id: self.id)
      vote.save
    else
      return "must have work id"
    end
  end
end
