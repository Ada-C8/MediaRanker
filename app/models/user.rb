class User < ApplicationRecord
  has_many: votes

  validates :name, presence: { message: "Please enter your username" }
  validates :name, length: { maximum: 10 }
end
