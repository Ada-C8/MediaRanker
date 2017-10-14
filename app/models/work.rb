class Work < ApplicationRecord

  # in test set each to nil to check validity
  validates :title, presence: true
  validates :category, presence: true
  validates :creator, presence: true
  # validates :publication_year, numericality: true

  has_many :votes
end
