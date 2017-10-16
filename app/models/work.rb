class Work < ApplicationRecord
  has_many :votes

  validates :category, presence: {message: "Select a category"}
  validates :title, presence: {message: "Enter a title"}
  validates :creator,presence: {message: "Enter a creator"}
  validates :publication_year, presence: {message: "Enter publication_year year"}

  def self.upvote(id)
    self.where(:id => id).update_all("upvotes = upvotes + 1")
  end
end
