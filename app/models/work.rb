class Work < ApplicationRecord
  has_many :votes

  validates :category, presence: { message: "Must have category" }
  validates :title, presence: { message: "Must have a title" }


# feedback from rideshare noted using an instance variable instead of .self. I worked on using @blah and was unsuccessful.
  def self.spotlight
    works = Work.all
    spotlight = works.max_by {|work| work.votes.count}

    return spotlight
  end

  def self.sort(category)
    return Work.all.where(category: category).sort_by{|work| -work.votes.count}
  end

  def self.top_ten(category)
    top_ten = self.sort(category)[0..9]
    return top_ten
  end
end
