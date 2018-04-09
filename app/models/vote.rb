class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  # use scope to make sure one vote per user per work
  validates_uniqueness_of :work_id, scope: [:user_id]
end
