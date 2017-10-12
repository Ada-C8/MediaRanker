class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: {message: "Media must have a title."}
  validates :category, presence: {message: "Media must have a category."}

  def self.sort_by_votes
    sort_by_votes = all.sort_by do |work|
      work.votes.count
    end
    return sort_by_votes
  end

  def self.all_albums
    albums = all.where(category: "albums")
    return albums
  end

  def self.all_books
    books = all.where(category: "books")
    return books
  end

  def self.all_movies
    movies = all.where(category: "movies")
    return movies
  end

  def self.top_ten_albums
    category = "album"
    self.top_ten(category)
  end

  def self.top_ten_books
    category = "book"
    self.top_ten(category)
  end

  def self.top_ten_movies
    category = "movie"
    self.top_ten(category)
  end

  private

  def self.top_ten(category)
    top_ten = Work.where(category: category)
    top_ten = top_ten.sort_by do |work|
      work.votes.count
    end
    return top_ten[0...10]
  end


end
