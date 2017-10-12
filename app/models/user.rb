class User < ApplicationRecord
  has_many :votes

  validates :name, presence: {message: "User must have a category."}
end
