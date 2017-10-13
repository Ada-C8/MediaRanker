class Work < ApplicationRecord
  has_many :votes, :dependent => :destroy

  validates :creator, presence: true, allow_nil: false
  validates :category, presence: true, inclusion: { in: %w(movie book album), allow_nil: false }
  validates :title, presence: true
  validates :publication_year, numericality: { only_integer: true, greater_than: 0, less_than: 10000 } #rework this, or set up proper error
end


# category validation template

# class Coffee < ApplicationRecord
#   validates :size, inclusion: { in: %w(small medium large),
#     message: "%{value} is not a valid size" }
# end
