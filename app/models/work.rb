class Work < ApplicationRecord

  has_many :votes, dependent: :destroy
  validates :title, presence: true
  validates :category, presence: true

  validates :title, uniqueness: { scope: :category, message: "has already been taken"}

  def self.albums
    @albums = Work.where(category: "album")
  end

  def self.books
    @books = Work.where(category: "book")
  end

  def self.movies
    @movies = Work.where(category: "movie")
  end

  def self.categories
    works = ["album", "book", "movie"]
  end

  def self.order_by_popularity(works)
    return works.sort { |x,y| y.votes.length <=> x.votes.length}
  end
end
