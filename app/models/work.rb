class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :category, presence: true
  validates :title,  presence: { message: "Please enter a title" }
  # I do not want to restrict title presence as more than one work can have the exact same title
  validates :creator,  presence: { message: "Please enter the creator" }
end
