class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: { message: "Please enter a title of your entry" }
  validates :category, presence: { message: "Please select a category" }

  CATEGORIES = ["Album", "Book", "Movie"]


end
