class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :category, presence: true
  validates :category, inclusion: { in: ["movie", "book", "album"], message: "%{value} is not a valid category" }

  validates :title, presence: true

  validates :title, uniqueness: { scope: :category,
    message: "The title should be unique within its category" }

  validates :creator, presence: true

  validates :publication_year, presence: true, numericality: { only_integer: true, less_than: DateTime.now.year }, length: { is: 4 }

end
