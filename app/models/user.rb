class User < ApplicationRecord
  has_many :votes
  validates :username, uniqueness: true, presence: true
end
