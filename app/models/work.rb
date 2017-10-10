class Work < ApplicationRecord
  belongs_to :user, optional: true
  has_many :votes
  validates :publication_year, numericality: { only_integer: true }
  validates :title, presence: true
  validates :creator, presence: true
end
