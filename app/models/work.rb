class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true
  validates :title, uniqueness: true

  def self.by_votes
    @works = Work.all.sort { |a, b| b.votes.count <=> a.votes.count}
    return @works
  end
end
