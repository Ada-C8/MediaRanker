class User < ApplicationRecord
  validates :name, :joined_on, presence: true
end
