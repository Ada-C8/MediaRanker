class Work < ApplicationRecord
  has_and_belongs_to_many :votes, dependent: :destroy
  validates :title, presence: true
  validates :category, presence: true

end
