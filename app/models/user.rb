class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :name, uniqueness: true
end
