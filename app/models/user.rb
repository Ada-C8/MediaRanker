class User < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :username, presence: {message: "Username is required."}
  validates :username, uniqueness: {message: "Username already exists."}



  def list_votes(user)
    @votes = Vote.all
    @works = Work.all
    user_works = []
    votes = @votes.where(user_id: user)
    votes.each do |vote|
      user_works << @works.find(vote.work_id).title
    end
    return user_works
  end

end
