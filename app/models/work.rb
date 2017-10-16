class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

# must provide a title
validates :title, presence: {message: "Title is Required"}
validates :title, uniqueness: {message: "Someone Else has Already Added that Work"}
validates :description, length: { maximum: 200, message: "The description is too long" }



def counter
  @votes = Vote.all
  return @votes.where(work_id: id).count
end


def list_users(work)
  @votes = Vote.all
  @users = User.all
  work_voters = []
  votes = @votes.where(work_id: work)
  votes.each do |vote|
    work_voters << @users.find(vote.user_id).username
  end
  return work_voters
end


end
