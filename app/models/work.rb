class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :creator, presence: true
  validates :category, presence: true
  validates :publication_year, presence: true

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
