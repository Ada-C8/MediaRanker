class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, presence: true
  # validates :work_id, presence: true, uniqueness: {scope: :user_id}
  validate :unique_vote_for_user

  private
  def unique_vote_for_user
    errors.add(user.name, 'has already voted for this work.') if Vote.find_by(user_id: user_id, work_id: work_id)
  end
end
