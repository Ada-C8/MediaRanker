class User < ApplicationRecord
  has_many :votes

  validates :name, presence: true, uniqueness: true

  validates_presence_of :votes
end
