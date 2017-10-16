class User < ApplicationRecord
  has_many :votes

  validates :name, presence: { message: "Username cannot be blank!" }, uniqueness: true
end
