class Vote < ApplicationRecord
  validates :user_id, :media_instance_id, presence: true
  # validates_uniqueness_of :scope => [:user_id, :media_instance_id]
  belongs_to :user
  belongs_to :media_instance
end
