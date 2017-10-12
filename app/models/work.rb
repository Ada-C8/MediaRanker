class Work < ApplicationRecord
  validates :title, presence: true

  def self.top_work
    # return the instance with the highest number of votes
    self.all.max_by { |work| work.votes.count }
  end
end
