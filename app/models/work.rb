class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: {scope: :category, message: "There is already a Work of this category with this title " }

  def self.top_ten(category)
    works_in_category = self.where(category: category)
    sorted = works_in_category.sort{ |x,y| x.votes.count <=> y.votes.count }

    top_ten = sorted.reverse.take(10)

    return top_ten
  end

  def self.top_work
    sorted_by_votes = self.all.sort{ |x,y| x.votes.count <=> y.votes.count }
    return sorted_by_votes.last
  end
end
