class VotesController < ApplicationController

  def index
    if params[:work_id]
      @votes = Work.find(params[:work_id]).votes
    else
      @votes = Vote.all
    end
  end

  def new
    @vote = Vote.new
    if session[:logged_in_user]
      create
    else
      flash.now[:status] = :failure
      flash.now[:message] = "You must be logged in to vote!"
    end
  end

  def create
    user = User.find(session[:logged_in_user])
    if user
      @vote = Vote.new
      @vote.work = Work.find(params[:work_id])

      @vote.user = user
      exists = @vote.work.votes.select { |vote| vote.user_id == user.id }
      if exists.length > 0
        flash[:status] = :failure
        flash[:message] = "Cannot vote for a work more than once!"
      else
        @vote.date = DateTime.now
        save_and_flash(@vote)
      end
      redirect_to works_path
    end
  end

  private

  def vote_params
    return params.require(:vote).permit(:user_id, :work_id, :date)
  end
end
