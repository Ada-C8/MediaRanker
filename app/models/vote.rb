class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user, presence: true
  validates :work, presence: true, uniqueness: {scope: :user, message: "user: has already voted for this work" }
end
