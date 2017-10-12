class User < ApplicationRecord

  validates :name, presence: {messages: "Please enter a username"}
  validates :joined, presence: {messages: "Must have a joined date"}
end
