class Vote < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true

  belongs_to :work
  validates :work_id, presence: true

end
