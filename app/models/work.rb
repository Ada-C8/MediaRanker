class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: { scope: [:category], message: "This title already exists in this category"}
  validates :category, presence: true

  def self.works_by_category
    categories = Hash.new

    work_cats = Work.all.pluck(:category).uniq
    work_cats.each do |cat|

      categories[cat.capitalize] = sorted_by_vote(Work.where(category: cat))
    end

    return categories
  end

  def self.sorted_by_vote(array_of_works)
    sorted = array_of_works.sort_by { |work| work.votes.count }
    return sorted.reverse
  end

end
