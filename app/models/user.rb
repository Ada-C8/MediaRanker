class User < ApplicationRecord
  has_many :votes
  validates :name, presence: true, length: { minimum: 1, message: "Can't be blank" }
end
