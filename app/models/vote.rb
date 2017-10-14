class Vote < ApplicationRecord

  belongs_to :work
  belongs_to :user

  validates :user_id, presence: {messages: "Must have a user id"}
  validates :work_id, presence: {messages: "Must have a work id"}
  validates :user_id, uniqueness: { scope: :work_id }

  def self.can_upvote?
    all_votes = Vote.all
  end


end
