class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

# must provide a title
validates :title, presence: {message: "%{value} must be given"}

def score
  @work = Work.find(params[:id])
  @votes = Vote.all
  @votes.where(work_id: @work.id).count
  return scores
end

# validates :title, uniqueness: {message: "%{value} already exists"}
end
