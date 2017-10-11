class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
  validates :pub_year, numericality: { only_integer: true, less_than: 2018 }
end
