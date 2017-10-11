class Work < ApplicationRecord
  has_many :votes

  def self.books
    @books = Work.where(category: "book")
  end

  def self.albums
    @albums = Work.where(category: "album")
  end

  def self.movies
    @movies = Work.where(category: "movie")
  end

end
