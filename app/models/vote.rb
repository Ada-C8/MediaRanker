class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id   # need to not allow more than one per user
end
