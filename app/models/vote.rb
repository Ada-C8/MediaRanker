class Vote < ApplicationRecord

  belongs_to :work
  belongs_to :user

  validates :user_id, presence: {messages: "Must have a user id"}
  validates :work_id, presence: {messages: "Must have a work id"}
end
