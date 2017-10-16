class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true, uniqueness: {scope: :category, message: "has already been taken" }

  def self.sorted_by_votes(category)
    works_in_category = self.where(category: category)
    sorted = works_in_category.sort{ |x,y| x.votes.count <=> y.votes.count }

    return sorted.reverse
  end

  def self.top_work
    sorted_by_votes = self.all.sort{ |x,y| x.votes.count <=> y.votes.count }
    return sorted_by_votes.last
  end
end
