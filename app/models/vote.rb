class Vote < ApplicationRecord
  belongs_to :work, counter_cache: true
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :work_id, message: "You have already voted."}
end
