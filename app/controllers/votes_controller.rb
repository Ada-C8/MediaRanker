class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def show
  end

  def new
    @vote = Vote.new
    @user_id = session[:logged_in_user]['id'].to_i
    @work_id = vote_params
  end

  def create
    @vote = Vote.new
    @vote.user_id = session[:logged_in_user]['id'].to_i
    @vote.work_id = vote_params
    @vote.save
    if @vote.save
      flash[:success] = "Successfully upvoted!"
    else
      flash[:failure] = "You cannot upvote twice!"
    end
  end


private
  def vote_params
    params.require(:works).permit(:id)
  end
end
