class User < ApplicationRecord
  has_many :votes

  validates :name, presence: { message: "Enter a username" }
end
