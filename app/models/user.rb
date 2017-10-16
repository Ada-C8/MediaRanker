class User < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :name, presence: { message: "Username cannot be blank!" }, uniqueness: true

end
