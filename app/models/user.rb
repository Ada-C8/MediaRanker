class User < ApplicationRecord
  has_many :votes

  validates :name, presence: true
  # QUESTION: why does this work in my tests but not on the web?
  # normalize_attribute :name, :with => :strip
# NOTE: won't work because I can't access session
# def self.logged_in_user
#   return User.where(id: session[:logged_in_user])
# end
end
