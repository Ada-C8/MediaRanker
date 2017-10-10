class Work < ApplicationRecord
  has_many :vote

  validates :title, presence: true
end
