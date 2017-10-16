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

  def self.top_ten_albums
  album = Work.where(category: "album")
  return album.sort_by {|work| -work.votes.count }.take(10)
  end

  def self.top_ten_movies
  movie = Work.where(category: "movie")
  return movie.sort_by {|work| -work.votes.count }.take(10)
  end

  def self.top_ten_books
  book = Work.where(category: "book")
  return book.sort_by {|work| -work.votes.count }.take(10)
  end
end
