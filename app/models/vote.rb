class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user, presence: true
  validates :work, presence: true, uniqueness: { scope: [:user_id], message: "You have already voted for this work"}

end
