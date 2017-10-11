class Work < ApplicationRecord
  #validations
  validates :title, presence: { message: "can't be blank" }
  validates :category, presence: { message: "can't be blank" }

  #relationships
  has_many :votes

end
