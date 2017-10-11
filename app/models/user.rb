class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :name, presence: true
  # do we want to require unique user names??
  validates_uniqueness_of :name, message: "user name has already been taken"
end
