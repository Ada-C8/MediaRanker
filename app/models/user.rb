class User < ApplicationRecord

  has_many :votes

  validates :name, presence: {messages: "Please enter a username"}

end
