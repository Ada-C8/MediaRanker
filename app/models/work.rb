class Work < ApplicationRecord

  validates :title, presence: { message: "Please enter a title of your entry" }
  validates :category, presence: { message: "Please select a category" }

  # @@categories = ["Albums", "Books", "Movies"]

end
