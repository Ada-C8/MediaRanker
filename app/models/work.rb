class Work < ApplicationRecord
  has_many :votes

  def self.get_categories
    return Work.distinct.pluck(:category).sort
  end

  def self.get_top_works(categories)
    all_top_works = {}
    categories.each do |a_category|
      this_category_top_works = Work.where(category: a_category).joins(:votes).group(:id).order("count(votes.id)").limit(10)
      all_top_works[a_category] = this_category_top_works
    end
    return all_top_works
  end
end
