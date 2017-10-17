class Work < ApplicationRecord

  validates :category, presence: true
  validates :title, presence: true, uniqueness: true

  has_many :votes
  scope :top10movies, -> {
    where(category: "movie").select("works.id, count(votes.id) AS votes_count").left_joins(:votes).group("works.id").order("votes_count DESC").limit(10)
  }
  scope :top10books, -> {
    where(category: "book").select("works.id, count(votes.id) AS votes_count").left_joins(:votes).group("works.id").order("votes_count DESC").limit(10)
  }
  scope :top10albums, -> {
    where(category: "album").select("works.id, count(votes.id) AS votes_count").left_joins(:votes).group("works.id").order("votes_count DESC").limit(10)
  }
  scope :topwork, -> {
    select("works.id, count(votes.id) AS votes_count").joins(:votes).group("works.id").order("votes_count DESC").limit(1)
  }
end
