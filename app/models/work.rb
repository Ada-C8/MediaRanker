class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes


  validates :title, presence: true, uniqueness: {scope: :category}
  validate :legal_category

  LEGAL_CATEGORIES = ["album", "book", "movie"]

  def self.all_categories
    LEGAL_CATEGORIES
  end

  def self.best
    Work.all.sort_by{|w| -w.votes.count}.first
  end

  def self.best_10(category)
    Work.where(category: category).sort_by{|w| -w.votes.count}[0...10]
  end

  def recs
    works = Hash.new(0)

    votes.each do |v|
      v.user.votes.each do |vote|
        work = vote.work
        works[work.title] += 1 unless work.title == title
      end
    end
    works
  end

  def rec_list
    works = recs
    works.keys.sort_by{|t| -works[t]}[0...3]
  end

  private
  def legal_category
    errors.add(:category, 'is not a legal category') unless LEGAL_CATEGORIES.include? category
  end
end
