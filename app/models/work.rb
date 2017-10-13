class Work < ApplicationRecord

  has_many :votes

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

  private

  def self.sort_by_most_votes
    return Work.all.sort_by {|work| -work.votes.count}
  end
end
