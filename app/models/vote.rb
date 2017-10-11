class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  # validations
  validates :work_id, presence: { message: "can't be blank" }
  validates :user_id, presence: { message: "can't be blank" }
end
