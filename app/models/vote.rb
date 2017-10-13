class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user, presence: true, uniqueness: { scope: [:work_id], message: "You have already voted for this work"}
  validates :work, presence: true

  def create
    Vote.create(user: (something), work: (some work))
  end
end
