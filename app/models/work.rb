class Work < ApplicationRecord
  has_many :votes

  def self.albums
    @albums = Work.where(category: "album")
  end

  def self.books
    @books = Work.where(category: "book")
  end

  def self.movies
    @movies = Work.where(category: "movie")
  end
end
