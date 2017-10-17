class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: { scope: :creator, message: "This media has already been added." }
  validates :category, presence: true
  validates :publication_year, allow_blank: true, numericality: true, length: { is: 4 }

  def self.top_work
    # return the instance with the highest number of votes
    self.all.max_by { |work| work.votes.count }
  end
end
