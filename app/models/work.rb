class Work < ApplicationRecord

  CATEGORIES = ["album", "book", "movie"]
  has_many :votes, :dependent => :destroy

  validates :creator, presence: true, allow_nil: false
  validates :category, presence: true, inclusion: { in: CATEGORIES, allow_nil: false }
  validates :title, presence: true
  validates :publication_year, numericality: { only_integer: true, greater_than: 0, less_than: 9999 } #rework this, or set up proper error


  # def self.spotlight
  #   return all.order(total_votes: :desc).first
  # end
end
