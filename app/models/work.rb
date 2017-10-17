class Work < ApplicationRecord
  #validations
  validates :title, presence: { message: "can't be blank" }
  validates :category, presence: { message: "can't be blank" }

  #relationships
  has_many :votes

  # custom methods
  def self.sorted_works(category)
    return Work.all.where(category: category).sort_by{|work| -work.votes.count}
  end

  def self.top_ten_works(category)
    top_works = Work.sorted_works(category)
    return top_works[0..9]
  end

  def self.top_work
    sorted = Work.all.sort_by{|work| -work.votes.count}
    return sorted.first
  end
end
