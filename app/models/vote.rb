class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true
  validates :work_id, presence: true


  # validate uniqueness, validate that user exists/hasn't voted before
end
