class User < ApplicationRecord

  has_many :votes

  validates :name, presence: true
end

# QUESTION: I tried stripping white space from the beginning and end of the User name that was entered, but either it passed my tests but didn't work on my rails app, or it broke the test that a vote could be created with all fields. below are two examples of what I tried:

  # 1.
    # before_validation :strip_blanks
    # def strip_blanks
    #   self.name = self.name.strip!
    # end

  # 2.
   # normalize_attribute :name, :with => :strip
