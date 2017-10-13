class User < ApplicationRecord
  has_many :vote

  validates :name, presence: {message: "User needs a name"}

end
