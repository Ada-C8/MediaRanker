class Work < ApplicationRecord
  has_many :votes

  # validates :category, presence: true {message: "Must have category"}
  # validates :title, presence: true

  def self.spotlight
    works = Work.all
    spotlight = works.max_by {|work| work.votes.count}
    spotlight.title
  end
end
