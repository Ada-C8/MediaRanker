class Work < ApplicationRecord
  CATEGORIES = ['album', 'book', 'movie']
  has_many :votes

  validates :title, presence: true
  validates :category, presence: true

  def self.sort_by_vote_count
    sorted = Work.all.sort_by{|work| -work.votes.count}
    return sorted
  end

  def self.top_work
    return sort_by_vote_count.first
  end # top_work

  def self.top_ten(category)
    unless CATEGORIES.include? category
      raise ArgumentError.new("Invalid category #{category}")
    end

    return Work.all.where(category: category).sort_by{|work| -work.votes.count}[0..9]
  end


  # for this example it is ok to have all this into one method
  #     - could put the sort by vote count in it's own method
  #                 - then another method calls the first from the whole list
  #                 - and another method calls the first from a certain category in the list (maybe take the category as an argument)
end
