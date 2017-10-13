class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true, uniqueness: {scope: :category, message: "There is already a Work of this category with this title " }
end
