class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  # again not sure how to implement the @user_votes_arary method. see original comment in work.rb's custom methods
  def self.user_votes_arary(user_id)
    Vote.where(user_id: user_id)

  end
end
