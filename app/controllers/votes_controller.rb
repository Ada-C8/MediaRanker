class VotesController < ApplicationController
  before_action :find_vote, only: [:show, :edit, :update, :destroy]

  def index
    # @vote = Vote.all
  end

  def show
    # redirect_to votes_path unless @vote
  end

  def new
    @vote = Vote.new(work_id: params[:pass_work_id])
  end

  def create
    # if Vote.where({ user_id: ssession[:user_id], work_id: params[:pass_work_id].to_i }).count > 0
    #   flash[:status] = :failure
    #   flash[:message] = "You already voted for this work"
    #   flash[:details] = @vote.errors.messages
    #   redirect_to request.referrer, notice: "You're being redirected"
    # else
      @vote = Vote.new(work_id: params[:pass_work_id], user_id: session[:user_id])
      if @vote.save
        flash[:status] = :success
        flash[:message] = "Successfully upvoted!"
        redirect_to request.referrer, notice: "You're being redirected"
      else
        flash[:status] = :failure
        flash[:message] = "Could not upvote"
        flash[:details] = @vote.errors.messages
        redirect_to request.referrer, notice: "You're being redirected"
      end
    # end
  end

  def edit
  end

  def update
    redirect_to vote_path unless @vote
    if @vote.update_attributes vote_params
      redirect_to vote_path(@vote.id)
    else
      render :edit
    end
  end

  def destroy
    @vote.destroy
    redirect_to votes_path
  end


  private

  def vote_params
    return params.require(:vote).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_vote
    # redirect_to votes_path unless @vote
    @vote = Vote.find_by_id(params[:id])
  end
end
