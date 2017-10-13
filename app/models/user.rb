class User < ApplicationRecord
  has_many :votes

  validates :name, presence: true
  # QUESTION: why does this work in my tests but not on the web?
  # normalize_attribute :name, :with => :strip
end
