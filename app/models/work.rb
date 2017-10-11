class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :category, presence: true
  validates :title, uniqueness: {scope: :category}
  # this could be used to make sure a COMBINATION of fields is unique.

end
