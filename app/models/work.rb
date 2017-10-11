class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :category, presence: true
  validates :title, presence: true
end
