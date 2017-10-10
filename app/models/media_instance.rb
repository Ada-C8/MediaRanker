class MediaInstance < ApplicationRecord
  validates :title, :media_type, presence: true
  has_many :votes
end
