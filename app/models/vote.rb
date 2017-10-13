class Vote < ApplicationRecord
  validates :user_id, presence: {messages: "Must have a user id"}
  validates :work_id, presence: {messages: "Must have a work id"}
  validates :voted_on, presence: {messages: "Must have a vote date"}
end
