class MediaInstance < ApplicationRecord
  validates :title, :media_type, presence: true
  has_many :votes, dependent: :destroy

  def self.ten_by_type(type)
    (where(media_type: type).sort{|instance| instance.votes.count}.reverse)[0..4]
  end

end
