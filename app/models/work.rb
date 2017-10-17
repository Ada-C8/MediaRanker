class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true
  validates :category, presence: true

  def self.top_work
    top_work = sort.first
    return top_work
  end

  def self.top_ten(category)
    top_ten = sort.find_all { |work| work.category == category}
    if top_ten.count > 10
      top_ten = top_ten.first(10)
    end
    return top_ten
  end

  private

  def self.sort
    Work.all.sort_by {|work| -work.votes.count}
  end

end
