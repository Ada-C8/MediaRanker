class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

# must provide a title
validates :title, presence: {message: "%{value} must be given"}

# def score
#   votes.count
# end

# validates :title, uniqueness: {message: "%{value} already exists"}
end
