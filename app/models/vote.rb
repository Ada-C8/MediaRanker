class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :date, presence: true
end
