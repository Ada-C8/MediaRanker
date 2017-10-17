class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  has_many :votes

  def self.popularity(category)
    top = Work.where(category: category).sort_by{|work| -work.votes.count}
    return top
  end

  def self.top_ten(category)
    return popularity(category) [0..9]
  end

  def self.spotlight
    return Work.all.sort_by{|work| -work.votes.count}.first
  end
end
