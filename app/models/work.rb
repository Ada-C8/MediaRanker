class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: {message: 'Please provide a title for the type of media.'}
end
