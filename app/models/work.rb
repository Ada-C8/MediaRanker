class Work < ApplicationRecord
  has_many :votes #, dependent: :destroy

  validates :title, presence: true

  # def get_top_10_by_category
  #
  # end
  def self.top_movies
    return Work.where(category: "movie").limit(10)
  end
end
