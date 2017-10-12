class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, presence: true
  validates :work_id, presence: true, uniqueness: {scope: :user_id}
end
