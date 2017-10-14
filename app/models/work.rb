class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: {scope: :category, message: "There is already a Work of this category with this title " }

  def upvote
    #if user is logged in
    #then you can create a vote on a work
    #else, flash error that says you must be logged in to upvote
  end
end
