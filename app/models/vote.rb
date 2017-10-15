class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user, presence: true
  validates :work, presence: true, uniqueness: {scope: :user, message: "There is already a vote from this user for this work" }
end
