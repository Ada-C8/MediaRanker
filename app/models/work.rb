class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: { scope: :creator,
    message: "This work already exists" }
end
