class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :title, uniqueness: { scope: :creator, message: "This media has already been added." }

  def self.top_work
    # return the instance with the highest number of votes
    self.all.max_by { |work| work.votes.count }
  end

end
