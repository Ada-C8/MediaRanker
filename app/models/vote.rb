class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :work_id, presence: true
  validates :user_id, presence: true, uniqueness: {scope: :work_id, message: "You've already voled for this work"}

  # again not sure how to implement the @user_votes_arary method. see original comment in work.rb's custom methods
  def self.user_votes_arary(user_id)
    Vote.where(user_id: user_id)

  end


# create session through ip
  def initialize(work_id, user_id)
    @work_id = work_id
    
    @user_id = user_id
  end


end
