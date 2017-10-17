class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, numericality: { only_integer: true }, presence: { message: "User is not valid!" }
  validates :work_id, numericality: { only_integer: true }, presence: { message: "Work is not valid!" }

  validates_uniqueness_of :user_id, :scope => :work_id, :message => "You cannot vote for the same media twice"

  validates_presence_of :user
  validates_presence_of :work
end
