class Work < ApplicationRecord
  CATEGORIES = ["book", "movie", "album"]
  has_many :votes
  validates :title, presence: true
  validates :category, presence: true, inclusion: { in: %w(book album movie)}

end
