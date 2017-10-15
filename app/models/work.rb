class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

# must provide a title
validates :title, presence: {message: "%{value} must be given"}

def testing(input)
  @votes = Vote.all
  total = @votes.where(work_id: input).count
  return total
end

# def score
#   @work = Work.find(params[:id])
#   @votes = Vote.all
#   @votes.where(work_id: @work.id).count
#   return scores
# end

end
