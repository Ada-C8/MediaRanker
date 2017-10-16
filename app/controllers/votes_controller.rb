class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create

    @vote = Vote.new(user_id:session[:user_id], work_id:params[:id])
    # vote.user_id = session[:user_id]

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(params[:id])
    else
      error = @vote.errors.messages
      if !error[:user].empty?
        flash.now[:error] = "You must log in to do that"
      else
        flash.now[:error] = "You can't upvote more than once!"
      end
      redirect_to work_path(params[:id])
    end
  end
end
