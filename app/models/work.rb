class Work < ApplicationRecord
  has_many :votes

  def self.top_ten(category)
    return Work.where(category: category).order(votes_count: :desc).take(10)
  end

  def get_upvotes
    return Vote.where(work: self)
  end
end
