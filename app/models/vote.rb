class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  # validates :user_id, presence: {message: "You must log in to do that"}
  validates :work_id, presence: {message: ""}
  validates :user_id, uniqueness: { scope: :work_id,
    message: " has already voted for this work" }, presence: {message: "You must log in to do that"}
end
