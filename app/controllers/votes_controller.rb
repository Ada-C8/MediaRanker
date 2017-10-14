class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def create
    work = params[:id].to_i
    user = session[:logged_in_user]['id']
    @vote = Vote.new(user_id: user, work_id: work )

    @vote.save
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(@vote.work_id)
    else
      redirect_to work_path(params[:id])
      flash[:failure] = "You cannot upvote twice!"
    end
  end

end
