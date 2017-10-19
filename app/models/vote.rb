class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user
  validates :user_id, :work_id, :category, presence: true
end
