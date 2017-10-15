class VotesController < ApplicationController
  before_action :find_vote, only: [:show, :edit, :update, :destroy]

  def index
    @vote = Vote.all
  end

  def show
    redirect_to votes_path unless @vote
  end

  def new
    @vote = Vote.new(work_id: params[:pass_work_id])
  end

  def create
    @vote = Vote.new(work_id: params[:pass_work_id], user_id: session[:logged_in_user])
    @vote.user_id = 1
    if @vote.save
      redirect_to works_path
    else
      redirect_to users_path
      # render :new
    end
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
