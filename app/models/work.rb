class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  belongs_to :user

  validates :category, presence: true
  validates :category, inclusion: { in: ["movie", "book", "album"], message: "%{value} is not a valid category" }

  validates :title, presence: true

  validates :title, uniqueness: { scope: :category,
    message: "The title should be unique within its category" }

  validates :creator, presence: true

  validates :publication_year, presence: true, numericality: { only_integer: true, less_than: (DateTime.now.year + 1), more_than: 0 },  length: { is: 4 }

  def number_of_vote
    vote_num = 0
    votes.each do |vote|
      vote_num += 1
    end
    return vote_num
  end

  def self.top_work
    max_vote = 0
    max_work = nil
    if Vote.all.count > 0
      Work.all.each do |work|
        if work.number_of_vote > max_vote
          max_vote = work.number_of_vote
          max_work = work
        end
      end
      return max_work
    else
      return max_work = Work.all.sample
    end
  end

  def self.top_title
    unless top_work == nil
      return Work.top_work.title
    end
  end

  def self.top_creator
    unless top_work == nil
      return Work.top_work.creator
    end
  end

  def self.top_votes
    unless top_work == nil
      return Work.top_work.number_of_vote
    end
  end

  def self.top_description
    if Work.top_work.description == nil
      return "No description"
    else
      return Work.top_work.description
    end
  end

end
