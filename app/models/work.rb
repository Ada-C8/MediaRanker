class Work < ApplicationRecord
  has_many :votes

  validates :category, presence: true
  validates :title, presence: true
  # I do not want to restrict title presence as more than one work can have the exact same title
  validates :creator, presence: true
end
