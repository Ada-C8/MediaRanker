class Work < ApplicationRecord
  belongs_to :user, optional: true
  has_many :votes
  validates :publication_year, numericality: { only_integer: true, allow_blank: true }
  validates :title, presence: true
  validates :creator, presence: true
  validates :category, presence: true
end
