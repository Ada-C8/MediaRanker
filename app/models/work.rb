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

  def self.top_ten(category)
    return Work.all.where(category: category).sort_by{|work| -work.votes.count}[0..9]
  end

  # added during wave two so no test
  # not sure if I am going to utilize this method. If you do not see it used, I forgot to delet/comment it out.
  # def work_from_user_vote_array(user_id)
  #   Vote.user_votes_arary(user_id).each do |vote|
  #     works_array = []
  #     works_array << Work.find(vote.work_id)
  #   end
  #   return works_array
  # end


end
