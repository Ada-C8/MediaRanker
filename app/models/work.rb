class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
  # validates :pub_year, numericality: { only_integer: true, less_than: 2018 }


  def total_votes(id)
    @work = Work.all
    counter = 0

    votes.each do |vote|
      if vote.work_id == id
        counter += 1
      end
    end
    return counter
  end

end
