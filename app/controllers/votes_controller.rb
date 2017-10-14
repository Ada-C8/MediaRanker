class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    user = User.find_by(id: params[:user][:id])

    if user == nil
      flash[:status] = :failure
      flash[:message] = "Sorry, you must be logged in to vote."
      redirect_to work_path, status: :bad_request
      return
    end

    work = Work.find_by(id: params[:work][:id])

    if work == nil
      flash[:status] = :failure
      flash[:message] = "Sorry, that media no longer exists in the database."
      redirect_to works_path, status: :bad_request
      return
    end

    @vote = Vote.new(user_id: user.id, work_id: work.id)

    Vote.votes_by_user(user).each do |vote|
      if vote.work_id == work.id
        flash[:status] = :failure
        flash[:message] = "You have already voted on this work - you can only vote once."
        redirect_to work_path, status: :bad_request
        return
      end
    end

    if @vote.save
      flash[:status] = :success
      flash[:message] = "Thank you for your vote!"
      redirect_to work_path
      return
    else
      flash[:status] = :failure
      flash[:message] = "Sorry, your vote could not be processed."
      redirect_to work_path, status: :bad_request
      return
    end

  end

  # private
  # def vote_params
  #   params.require(:user, :work)
  # end
end
