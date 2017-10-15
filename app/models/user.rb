class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :works, dependent: :destroy
  validates :username, uniqueness: true
end
