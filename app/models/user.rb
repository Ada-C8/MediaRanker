class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :username, uniqueness: true, presence: true
end
