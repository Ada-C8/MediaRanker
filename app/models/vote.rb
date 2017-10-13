class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, numericality: { only_integer: true }, uniqueness: true
  validates :work_id, numericality: { only_integer: true }, uniqueness: true
end
