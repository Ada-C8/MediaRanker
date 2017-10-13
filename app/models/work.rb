class Work < ApplicationRecord
  has_many :vote

  validates :title, presence: {message: "Work needs a title"}
  validates :category, presence: {message: "Work needs a category"}

  def vote
  end

end
