class User < ApplicationRecord
  has_many :votes

  validates :user_name, format: { with: /[a-zA-Z]/ }
end
