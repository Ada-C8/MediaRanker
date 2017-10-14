class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, numericality: { only_integer: true }
  validates :work_id, numericality: { only_integer: true }

  validates_uniqueness_of :user_id, :scope => :work_id

  validates_presence_of :user
  validates_presence_of :work
end
