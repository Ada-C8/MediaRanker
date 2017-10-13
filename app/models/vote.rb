class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  # validates :user_id, presence: {message: "You must be logged in to vote"}
  # validates :work_id, presence: true
end
