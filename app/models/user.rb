class User < ApplicationRecord
  has_many :votes
  has_many :works
  validates :username, uniqueness: true
end
