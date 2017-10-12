class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true, uniqueness: { scope: [:category], message: "This title already exists in this category"}
  validates :category, presence: true
end
