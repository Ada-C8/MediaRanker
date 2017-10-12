class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes


  validates :title, presence: true, uniqueness: {scope: :category}

  LEGAL_CATEGORIES = ["album", "book", "movie"]

  def self.all_categories
    LEGAL_CATEGORIES
  end
end
