class Work < ApplicationRecord

  validates :category, presence: true
  validates :title, presence: true, uniqueness: true

  has_many :votes
  scope :top10, -> {
    select("works.id, count(votes.id) AS votes_count").left_joins(:votes).group("works.id").order("votes_count DESC").limit(10)
  }
end
