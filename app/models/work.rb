class Work < ApplicationRecord

  validates :category, presence: true

  validates :title, uniqueness: { scope: :category,
    message: "The title should be unique within its category" }

  validates :creator, presence: true

  validates :publication_year, presence: true, numericality: true

end
