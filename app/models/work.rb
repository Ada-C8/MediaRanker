class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true
  validates :category, presence: true

  def self.top_work
    top_work = sort.first
    return top_work
  end

  def self.top_ten
    # Work.

  end

  private

  def self.sort
    Work.all.sort_by {|work| -work.votes.count}

  end

end
