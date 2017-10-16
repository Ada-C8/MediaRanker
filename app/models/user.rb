class User < ApplicationRecord
  has_many :votes

  validates :name, presence: { message: "Username cannot be blank!" }, uniqueness: true

  def valid_votes(id)
    votes = find_user_works(id)
    return votes
  end

  private

  def find_user_works(id)
    votes = Vote.where(user_id: id)
    valid_votes = []
    # votes.each do |vote|
    #   if vote.valid?
    #     valid_votes << vote
    #   end
    # end
  end
end
