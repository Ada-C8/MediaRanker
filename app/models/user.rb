class User < ApplicationRecord
  #validations
  validates :username, presence: { message: "can't be blank" }, uniqueness: true

  #relationships
  has_many :votes
end
