class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true
  #the below validation is necessary for books that are turned into movies of the same name!
  validates :title, uniqueness: {scope: :category, message: "The title should be unique within this category"}
  validates :category, presence: true
  validates :category, inclusion: { in: %w(movie book album), message: "%{value} is not a valid input for category. Accepts categories movie, book, or album" }

  #The following test fails when I include the first pub_year validation below:
  #test_0003_requires both a title and category to be created
  validates :pub_year, presence: false, format: { with: /\d{4}/,
    message: "only allows a year format of 4 numbers (ex. 2017)" }

  validates :pub_year, numericality: { only_integer: true, less_than: DateTime.now.year }

  validates :pub_year, numericality: true, length: {is:4}


  def total_votes(id)
    counter = 0
    votes.each do |vote|
      if vote.work_id == id
        counter += 1
      end
    end
    return counter
  end


end
