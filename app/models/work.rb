class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true

  def self.all_works
    @works = Work.all
  end

  def self.top_work
   max_vote = 0
    Work.all_works.each do |w|
    if w.votes.count > max_vote
      max_vote = w.votes.count
    end
    end
    top_work = nil
    Work.all_works.each do |w|
      if w.votes.count == max_vote
        top_work = w
      end
      end
      return top_work
  end

  def self.top_works(category)
    works = {}
    Work.all_works.each do |w|
      if w.category == category
        works[w] = w.votes.count
      end
    end
    works.sort_by {|_key, value| value}
    return works.take(10)
  end
end
