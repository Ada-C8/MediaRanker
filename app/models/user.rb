class User < ApplicationRecord
  validates :username, presence: true
  has_many :votes, dependent: :nullify


  def vote(work)
    if Vote.find_by(user_id: self.id, work_id: work.id)
      return nil
    end

    vote = Vote.new(work: work)
    # pushing vote into votes creates the vote and connects to the user
    votes << vote
  end

end
