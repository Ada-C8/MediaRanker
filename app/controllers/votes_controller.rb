class VotesController < ApplicationController
  def create
  #def upvote
    # user = User.find_by(id: params[:id])
    # user = User.find_by(username: params[:username])
    user = User.find_by(username: session[:username])
    work = Work.find_by(id: params[:id])

    @vote = Vote.new(user,work)

    if @vote.save

    end

  end
end
