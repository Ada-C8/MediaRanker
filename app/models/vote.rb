class Vote < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :work, required: false

  validates :user_id, presence: :true
  validates :work_id, presence: :true

  def index
    @votes = Vote.all
  end


  def self.media_spotlight
    work_hash = Vote.group(:work_id).count
    media_max = work_hash.max_by{ |k,v| v}
    return Work.find(media_max[0])
  end

end
