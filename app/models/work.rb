class Work < ApplicationRecord
  validates :creator, :title, :published, :category,
            :description, presence: true
end
