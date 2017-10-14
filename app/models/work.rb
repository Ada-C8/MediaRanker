class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

# must provide a title
validates :title, presence: {message: "%{value} must be given"}

# must provide a vin
# validates :title, uniqueness: {message: "%{value} already exists"}
end
