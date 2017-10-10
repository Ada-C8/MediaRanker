class User < ApplicationRecord
  #validations
  validates :username, presence: { message: "can't be blank" }
  
  #relationships
  # has_and_belongs_to_many :votes
end
