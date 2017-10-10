class User < ApplicationRecord
  has_many :votes

  validates :name, presence: { message: "Please enter a username"}, uniqueness: true
end
