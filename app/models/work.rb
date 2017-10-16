class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :category, presence: true
  validates :title, presence: true
  # can't add two works of same title to same category
  validates_uniqueness_of :title, scope: [:category]

  def self.winner
    @works = Work.order(:created_at)
    @works.max_by {|work| work.votes.length}
  end

  def self.top_ten(type)
    category_list = Work.where(category: type)
    sorted = category_list.sort_by {|x| x.votes.length}.reverse
    ten = sorted.first(10)
    return ten
  end

end
