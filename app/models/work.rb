class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: { message: "Please enter a title of your entry" }
  validates :category, presence: { message: "Please select a category" }

  CATEGORIES = ["album", "book", "movie"]

  def self.top_work
    Work.all.sort_by { |work| -work.votes.count }.first
  end

  def self.top_ten(category, count = 10)
    Work.all.where(category: category).sort_by { |work| -work.votes.count }.first(count)
  end
end
