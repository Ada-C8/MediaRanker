class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: { message: "The title was not unique! Please choose a different one" }
  validates :description, length: { maximum: 500, message: "The description is too long" }

  def self.popular_works(category)
    top_works = Work.all.where(category: category).sort_by{|work| -work.votes.count}[0..9]
    return top_works
  end

  def self.sorted_works
    sorted = Work.all.sort_by{|work| -work.votes.count}
    return sorted
  end

  def self.top
    return sorted_works.first
  end

end
