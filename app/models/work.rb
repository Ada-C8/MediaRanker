class Work < ApplicationRecord
  #validations
  validates :title, presence: { message: "can't be blank" }
  validates :category, presence: { message: "can't be blank" }

  #relationships
  has_many :votes
  # pulls all of the disctinct values from the category attribute

  def self.popular_works(category)
    top_works = Work.all.where(category: category).sort_by{|work| -work.votes.count}[0..9]
    return top_works
  end

  def self.sorted_works
    all_works_sorted = Work.all.sort_by{|work| -work.votes.count}
    return all_works_sorted
  end

  def self.top_work
    return sorted_works.first
  end


  # def self.top_works(category)
  #   top_works = Work.where(category: category).joins(:votes).group(:id).order("count(votes.id) DESC").limit(10)
  #   return top_works
  # end
end
