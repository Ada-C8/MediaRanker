class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, numericality: { only_integer: true }
  validates :work_id, numericality: { only_integer: true }
end
