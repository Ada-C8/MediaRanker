class Vote < ApplicationRecord
  has_one :user
  has_one :work

  validates_uniqueness_of :work_id, scope: [:user_id]
end
