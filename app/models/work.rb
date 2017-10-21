class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: { message: "The title was not unique! Please choose a different one" }
  validates :description, length: { maximum: 500, message: "The description is too long" }

  def self.sort_by_category(category)
      return Work.where(category: category).sort_by{|work| -work.votes.count}
  end

  def self.popular_works(category)
    top_works = Work.sort_by_category(category)
    return top_works[0..9]
  end

  def self.sorted_all_works_together
    # helper method for the next method "self.top"
    sorted = Work.all.sort_by{|work| -work.votes.count}
    return sorted
  end

  def self.top
    return sorted_all_works_together.first
  end

end
