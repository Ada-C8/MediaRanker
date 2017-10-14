class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: { message: "Please enter a title of your entry" }
  validates :category, presence: { message: "Please select a category" }

  CATEGORIES = ["Album", "Book", "Movie"]

  def self.top_work
    Work.all.sort_by { |work| -work.votes.count }.first
  end

  def top_ten(array)
    array.sort_by { |work| -work.votes.count }.limit(10)
  end



end
