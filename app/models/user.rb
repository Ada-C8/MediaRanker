class User < ApplicationRecord
  has_many :votes
  validates :name, presence: true
  validates :name, uniqueness: true

  # def include_work?(work)
  #   votes.each do |vote|
  #     if vote.work = work
  #       return true
  #     end
  #   end
  #   return false
  # end

end
