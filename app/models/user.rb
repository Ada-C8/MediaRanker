class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true


end
