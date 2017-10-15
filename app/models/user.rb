class User < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :username, presence: true
  validates :date_joined, presence: true

end
