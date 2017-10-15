class User < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :username, presence: {message: "%{value} must be given"}

  def list_votes
    #go through votes
    #if the user id is found, print name of work
  end

  # def votes?(work)
  #   work.votes.where(user_id: id).any?
  # end
  # @zombies.each do |zombie|
  # zombie.name
  # zombie.brain.flavor
  #
  # for each zombie, seach list of brains to find flavor,
  #
  #   or
  #   @zombies = Zombie.includes(:brain).all
  #   will select zombies that are in the brain list
  #   then just seek out those ids
end
