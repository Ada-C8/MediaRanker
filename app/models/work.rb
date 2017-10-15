class Work < ApplicationRecord

  has_many :votes, dependent: :destroy

  #validates presence of category, title, creator
  validates :category, presence: {message: "The category must be present"}
  validates :title, presence: {message: "The title must be present"}
  validates :creator, presence: {message: "The creator must be present"}

  def self.top_work
    sorted_works = sort_by_most_votes
    top_work = sorted_works.first
    return top_work
  end

  def self.top_ten
    sorted_works = sort_by_most_votes
    top_ten = sorted_works[0..9]
    return top_ten
  end

  # def self.work_sorted_by_votes(work_category)
  #   sorted_works = sort_by_most_votes
  #   work_sorted_by_votes = sorted_works.find_all {|work| work.category == work_category}
  #
  #   return work_sorted_by_votes
  # end

  def self.albums_sorted_by_votes
    sorted_works = sort_by_most_votes
    albums_sorted_by_votes = sorted_works.find_all {|work| work.category == "album"}

    return albums_sorted_by_votes
  end

  def self.books_sorted_by_votes
    sorted_works = sort_by_most_votes
    books_sorted_by_votes = sorted_works.find_all {|work| work.category == "book"}

    return books_sorted_by_votes
  end

  def self.movies_sorted_by_votes
    sorted_works = sort_by_most_votes
    movies_sorted_by_votes = sorted_works.find_all {|work| work.category == "movie"}

    return movies_sorted_by_votes
  end

  private

  def self.sort_by_most_votes
    return Work.all.sort_by {|work| -work.votes.count}
  end
end
