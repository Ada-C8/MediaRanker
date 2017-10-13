class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: true
  validates :creator, presence: true
end
