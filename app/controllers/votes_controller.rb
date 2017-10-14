class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def show
  end

  # def new
  #   @vote = Vote.new
  #   @user_id = session[:logged_in_user]['id'].to_i
  #   @work_id = params[:id]
  # end

  def create
    @vote = Vote.new
    @vote.user_id = session[:logged_in_user][:id]
    @vote.work_id = params[:id].to_i
    @vote.save
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(@vote.work_id)
    else
      flash[:failure] = "You cannot upvote twice!"
      redirect_to work_path(params[:id])
    end
  end

end
