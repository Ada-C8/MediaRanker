class User < ApplicationRecord
  has_many :votes #, dependent: :destroy

  validates :username, presence: true, uniqueness: { message: "This username is already exists. Please choose a different one" }

end
