class Work < ApplicationRecord
  validates :title, presence: true
  validates :category, presence: true
  validates :creator, presence: true
  validates :publication_year, numericality: true

  has_many :votes
end
