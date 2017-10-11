class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :work, uniqueness: { scope: :user, message: "No duplicate votes" }

end
