class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :work_id, message: "You have already voted."}
  # need to not allow more than one per user, also, why can't i interpolate the category name?
end
