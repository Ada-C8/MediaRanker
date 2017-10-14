class Work < ApplicationRecord
  has_many :votes

  validates :category, presence: true {message: "Must have category"}
  validates :title, presence: true
end
