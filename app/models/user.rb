class User < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :username, presence: {message: "%{value} must be given"}

  def list_votes(user)
    @votes = Vote.all
    @works = Work.all
    user_works = []
    votes = @votes.where(user_id: user)
    votes.each do |vote|
      user_works << @works.find(vote.work_id).title
    end
    return user_works
  end

  




    # <%# votes = @votes.where(user_id: @user.id)  %>
    #
    # <%# votes.each do |vote| %>
    #   <%#  work = @works.find(vote.work_id) %>
    #   <%#= work.title %>
    # <%# end %>
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
