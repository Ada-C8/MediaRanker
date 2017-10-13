class Work < ApplicationRecord
  has_many :votes, :dependent => :destroy

  validates :creator, presence: true, allow_nil: false
  validates :category, presence: true, inclusion: { in: %w(movie book album), allow_nil: false }
  validates :title, presence: true
  validates :publication_year, numericality: { only_integer: true, greater_than: 0, less_than: 9999 } #rework this, or set up proper error
<<<<<<< HEAD

  def self.spotlight
    return all.order(total_votes: :desc).first
  end
end
=======
>>>>>>> master

  def self.spotlight
    return all.order(total_votes: :desc).first
  end
end
# category validation template

# class Coffee < ApplicationRecord
#   validates :size, inclusion: { in: %w(small medium large),
#     message: "%{value} is not a valid size" }
# end
