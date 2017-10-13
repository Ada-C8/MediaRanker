class User < ApplicationRecord
  has_many :votes

  validates :username, presence: true, uniqueness: true
  #will automatically login if the username is not unique
end
