class Work < ApplicationRecord

  has_many :votes

  #validates presence of category, title, creator
  validates :category, presence: {message: "The category must be present"}
  validates :title, presence: {message: "The title must be present"}
  validates :creator, presence: {message: "The creator must be present"}
end
