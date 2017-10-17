class Vote < ApplicationRecord
  # relationships
  belongs_to :user
  belongs_to :work

  # validations
  validates :work_id, presence: true
  validates :user_id, presence: true, uniqueness: {scope: :work_id}
end
