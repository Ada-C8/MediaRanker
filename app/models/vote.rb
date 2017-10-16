class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :work, presence: true
  validates :user, presence: true, uniqueness: {scope: :work, message: "has already voted for this work" }

  def created
    created_at.strftime('%B %d, %Y')
  end
end
