class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true

  def self.filter_by_category(category)
   works_of_category = Work.where(category: category)

   return works_of_category
  end

  def self.select_top_ten_of_category(category)
    top_ten = Work.filter_by_category(category).joins("LEFT JOIN votes ON works.id = votes.work_id").group(:id).order("count(votes.id) DESC").limit(10)

    return top_ten
  end

  def self.top_ten_books
    top_ten_books = select_top_ten_of_category("book")
  end

  def self.top_ten_albums
    return select_top_ten_of_category("album")
  end

  def self.top_ten_movies
    top_ten_movies = select_top_ten_of_category("movie")
  end

  def self.top_spot
    top_spot = Work.all.joins("LEFT JOIN votes ON works.id = votes.work_id").group(:id).order("count(votes.id) DESC")

    return top_spot.first
  end

end
