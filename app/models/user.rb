class User < ApplicationRecord
  has_many :upvotes

  validates :name, presence: true
end
