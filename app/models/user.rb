class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :name, presence: true, allow_blank: false
  validates_uniqueness_of :name, message: "user name has already been taken"
end
