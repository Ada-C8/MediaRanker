class Work < ApplicationRecord
  CATEGORIES = ["book", "movie", "album"]

  validates :title, presence: true
  validates :category, presence: true, inclusion: { in: %w(book album movie)}

end
