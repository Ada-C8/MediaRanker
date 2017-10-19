class User < ApplicationRecord
  has_many :votes, dependent: :destroy 
  validates :name, :joined_on, presence: true
end
