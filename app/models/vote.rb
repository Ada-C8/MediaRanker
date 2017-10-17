class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: { message: "Vote does not belong to a user"}
  validates :work_id, presence: { message: "Vote does not belong to a work"}
end
