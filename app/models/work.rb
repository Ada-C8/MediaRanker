class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true
  validates :creator, presence: true
  validates :category, presence: true
  validates :description, length: { maximum: 500, message: "The description is too long" }
end
