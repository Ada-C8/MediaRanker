class User < ApplicationRecord
  has_many :votes
  has_many :works
  validates :name, presence: true, uniqueness: true
end
