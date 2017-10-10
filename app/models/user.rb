class User < ApplicationRecord
  has_many :votes

  validates :name, presence: true
  # validate uniqueness
end
