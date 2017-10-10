class User < ApplicationRecord
  #validations
  validates :username, presence: { message: "can't be blank" }

  #relationships
  has_many :votes
end
