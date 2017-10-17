class Vote < ApplicationRecord
  belongs_to :work

  belongs_to :user

  validates :user_id, presence: true, uniqueness: {scope: :work_id, message: "You must be logged in to do that" }
  validates :work_id, presence: true
end
