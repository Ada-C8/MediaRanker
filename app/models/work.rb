class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: { message: "Work must have a title"}
end
