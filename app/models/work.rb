class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

# must provide a title
validates :title, presence: {message: "Title is Required"}
validates :title, uniqueness: {message: "Someone Else has Already Added that Work"}




def testing(input)
  @votes = Vote.all
  total = @votes.where(work_id: input).count
  return total
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

# def score
#   @work = Work.find(params[:id])
#   @votes = Vote.all
#   @votes.where(work_id: @work.id).count
#   return scores
# end

end
