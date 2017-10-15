class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :date, presence: true
  validates :user, uniqueness: { scope: :work,
    message: "has already voted for this work." }
end
