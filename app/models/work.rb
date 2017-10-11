class Work < ApplicationRecord
  has_many :upvotes, dependent: :destroy

  validates :title, presence: true
  validates :title, uniqueness: { scope: [:category]}
  validates :category, presence: true
  validates :publication_year, presence: true
  validates :creator, presence: true
end
