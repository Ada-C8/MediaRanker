class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true, uniqueness: { scope: [:creator, :category] }
  validates :creator, presence: true
  validates :publication_year, numericality: { only_integer: true }, allow_nil: true

  def self.get_categories
    return Work.distinct.pluck(:category).sort
  end

  def self.get_works
    works = {}
    categories = Work.get_categories
    categories.each do |a_category|
      category_works = Work.where(category: a_category)
      works[a_category] = category_works
    end
    return works
  end

  def self.get_top_work
    top_work = Work.joins(:votes).group(:id).order("count(votes.id) DESC").limit(1)[0]
    return top_work
  end

  def self.get_top_works(categories)
    all_top_works = {}
    categories.each do |a_category|
      this_category_top_works = Work.where(category: a_category).joins("LEFT JOIN votes ON works.id = votes.work_id").group(:id).order("count(votes.id) DESC").limit(10)
      all_top_works[a_category] = this_category_top_works
    end
    return all_top_works
  end
end
