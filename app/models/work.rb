class Work < ApplicationRecord
  has_many :votes

  validates :category, presence: {message: "Select a category"}
  validates :title, presence: {message: "Enter a title"}
  validates :creator,presence: {message: "Enter a creator"}
  validates :publication_year, presence: {message: "Enter publication_year year"}

  def self.media_spotlight
    works = Work.all
    works.max_by do |work|
      work.votes.count
    end
  end
end
