class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :work, uniqueness: { scope: :user, message: "You can't vote for a work more than once" }

end
