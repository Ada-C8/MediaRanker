class Work < ApplicationRecord
  has_many :votes

  validates :category, presence: true
  validates :title, presnce: true
  validates :creator, presence: true
  validates :description, presence: true
  validates :year, numericality: { only_integer: true}
end
