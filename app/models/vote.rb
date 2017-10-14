class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, presence: :true
  validates :user_id, uniqueness: {scope: :work_id}
  validates :work_id, presence: :true
end
