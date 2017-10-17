class Work < ApplicationRecord
  CATEGORIES = ["book", "movie", "album"]
  has_many :votes
  validates :title, presence: true
  validates :category, presence: true, inclusion: { in: %w(book album movie)}


  def self.sort_all(category)
    category.all.sort_by{ |work| -work.votes.count }
  end
end
