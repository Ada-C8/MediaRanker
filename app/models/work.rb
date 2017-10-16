class Work < ApplicationRecord
  has_many :votes
  validates :category, presence: true
  validates :title, presence: true

  def self.books
    @books = Work.where(category: "book")
  end

  def self.albums
    @albums = Work.where(category: "album")
  end

  def self.movies
    @movies = Work.where(category: "movie")
  end

  def self.categories
    @categories = ["album", "book", "movie"]
  end

end
