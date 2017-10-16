class Vote < ApplicationRecord
  validates :user_id, :work_id, :category, presence: true
end
