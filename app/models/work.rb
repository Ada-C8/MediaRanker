class Work < ApplicationRecord
  CATEGORIES = ['album', 'book', 'movie']
  has_many :votes, :dependent => :delete_all 

  validates :title, presence: true
  # NOTE: When I leave these validations in the rails app doesn't recognize that it received a title from the collection.sort drop down.
  # TODO: figure out what is going on with create and this validation to make it not recognize the category given in the drop down...
  # validates :category, presence: true
  # validates :category, inclusion: { in: %w( album book movie )}

  def self.sort_by_vote_count
    return Work.all.sort_by{|work| -work.votes.count}
  end

  def self.top_work
    return sort_by_vote_count.first
  end # top_work

  def self.top_ten(category)
    unless CATEGORIES.include? category
      raise ArgumentError.new("Invalid category #{category}")
    end

    return Work.category_sort(category)[0..9]
  end

  def self.category_sort(category)
    return Work.all.where(category: category).sort_by{|work| -work.votes.count}
  end # all_category

  def category
  end



  # for this example it is ok to have all this into one method
  #     - could put the sort by vote count in it's own method
  #                 - then another method calls the first from the whole list
  #                 - and another method calls the first from a certain category in the list (maybe take the category as an argument)
end
