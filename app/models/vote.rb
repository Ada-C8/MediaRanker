class Vote < ApplicationRecord
  validates :user_id, :media_instance_id, presence: true
  belongs_to :user
  belongs_to :media_instance
end
