class User < ApplicationRecord
  validates :name, :email, presence: true
  validates_format_of :email, :with =>  /\A\S+@.+\.\S+\z/
  validates :email, uniqueness: true
  has_many :votes
end
