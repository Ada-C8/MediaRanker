class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :category, presence: true
  validates :title, presence: true
  # can't add two works of same title to same category
  validates_uniqueness_of :title, scope: [:category]
end
