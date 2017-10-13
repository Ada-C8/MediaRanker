class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: { in: %w(movie book album), message: "%{value} is not a valid input for category. Accepts categories movie, book, or album" }

  #The following test fails when I include the first pub_year validation below:
  #test_0003_requires both a title and category to be created
  # validates :pub_year, format: { with: /\d{4}/,
  #   message: "only allows a year format of 4 numbers (ex. 2017)" }
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
